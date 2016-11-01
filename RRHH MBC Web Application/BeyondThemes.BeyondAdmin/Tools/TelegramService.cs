using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Threading;
using Telegram.Bot.Types.Enums;
using System.Diagnostics;
using DataTransferObjects;
using BeyondThemes.BeyondAdmin.Providers;

namespace BeyondThemes.BeyondAdmin.Tools
{

    public class TelegramService
    {
        //private const string bot_id = "240787257:AAHi78qbuStEm6B-tV5G33HMLhJwiREgO-k";
        private const string bot_id = "257291055:AAEFvfpq5NAN4w4X8vywfKGhW82PqYlg0xY";
        private static TelegramService _Instance = null;
        private TelegramService()
        {
            //Thread oThread = new Thread(new ThreadStart(this.listenMessages));
        }
        public static void createInstance()
        {
            if (_Instance == null)
            {
                _Instance = new TelegramService();
            }
        }
        public static TelegramService getInstance()
        {
            createInstance();
            return _Instance;
        }
        public async static Task<bool> sendMessage(string telegram_id, string message)
        {
            var Bot = new Telegram.Bot.TelegramBotClient(bot_id);
            Telegram.Bot.Types.Message msg = await Bot.SendTextMessageAsync(244853182 ,message);
            return true;
        }
        public async Task<TelegramStatus> getMessages()
        {
            using (var client = new HttpClient())
            {
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("https://api.telegram.org/bot"+bot_id+"/getUpdates?offset=0").Result;
                TelegramStatus telegramStatus = new TelegramStatus();
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    telegramStatus = new JavaScriptSerializer().Deserialize<TelegramStatus>(result);
                }
                return telegramStatus;
            }
        }
        public async void listenMessages()
        {
            int lastUpdate_id = 0;
            while (true)
            {
                var messages = await getMessages();
                foreach (var message in messages.result)
                {
                    if (Int32.Parse(message.update_id) > lastUpdate_id)
                    {
                        lastUpdate_id = Int32.Parse(message.update_id);
                        if (message.message.text.StartsWith("/subscribe"))
                        {
                            string[] words = message.message.text.Split(' ');
                            if(words.Length == 3)
                            {
                                string user = words[1];
                                string password = words[2];
                                UsersProvider userProvider = new UsersProvider();
                                UserDTO userDTO = userProvider.getUser(user).Result;
                                if (!String.IsNullOrEmpty(userDTO.user_id) && userDTO.password == password)
                                {
                                    if (String.IsNullOrEmpty(userDTO.telegram_id))
                                    {
                                        userDTO.telegram_id = message.message.from.id;
                                        userDTO.telegram_user = message.message.from.username;
                                        if (userProvider.putUser(userDTO).Result)
                                        {
                                            await sendMessage(message.message.from.id, "El usuario telegram " + userDTO.telegram_user + " se ha asignado correctamente a la cuenta de " + userDTO.name + " " + userDTO.fLastName + " " + userDTO.sLastName);
                                        }
                                    }
                                }
                                else
                                {
                                    await sendMessage(message.message.from.id, "El usuario o la contraseña son incorrectos");
                                }
                            }
                        }
                    }
                }
                await Task.Delay(10000);
            }
        }
        //public async Task refreshStatus()
        //{
        //    var Bot = new Telegram.Bot.TelegramBotClient(bot_id);
        //    var iMeessage = 0;
        //    while (true)
        //    {
        //        var updates = await Bot.GetUpdatesAsync();
        //        var metartext = "";
        //        foreach (var update in updates)
        //        {
        //            // subscribe cjimenez13@outlook.com Password12
        //            if (update.Message.Type == MessageType.TextMessage && update.Message.Text.StartsWith("/subscribe"))
        //            {
        //                var station = update.Message.Text.Substring(update.Message.Text.Length - 4);
        //                await Bot.SendChatAction(update.Message.Chat.Id, ChatAction.Typing);
        //                await Task.Delay(2000);
        //                var t = await Bot.SendTextMessage(update.Message.Chat.Id, metartext);
        //            }

        //            iMeessage = update.Id + 1;
        //        }
        //        await Task.Delay(1000);
        //    }
        //}
    }
    public class TelegramStatus
    {
        public string ok { get; set; }
        public List<TelegramMessages> result { get; set; }
    }
    public class TelegramMessages
    {
        public string update_id { get; set; }
        public TelegramMessage message { get; set; }
    }
    public class TelegramMessage
    {
        public string message_id { get; set; }
        public TelegramUser from { get; set; }
        public TelegramUser chat { get; set; }
        public string date { get; set; }
        public string text { get; set; }
    }
    public class TelegramUser
    {
        public string id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string username { get; set; }
        public string type { get; set; }
    }
}
