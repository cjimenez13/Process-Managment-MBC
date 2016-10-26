using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using System.Threading;
using Telegram.Bot.Types.Enums;

namespace BeyondThemes.BeyondAdmin.Tools
{

    public class TelegramService
    {
        private const string bot_id = "240787257:AAHi78qbuStEm6B-tV5G33HMLhJwiREgO-k";
        private static TelegramService _Instance = null;
        private TelegramService()
        {
            Thread oThread = new Thread(new ThreadStart(_Instance.refreshStatus));
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
        public async static Task<TelegramStatus> getMessages()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://api.telegram.org/");
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response = client.GetAsync("bot240787257:AAHi78qbuStEm6B-tV5G33HMLhJwiREgO-k/getUpdates?offset=0").Result;
                TelegramStatus telegramStatus = new TelegramStatus();
                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    telegramStatus = new JavaScriptSerializer().Deserialize<TelegramStatus>(result);
                }
                return telegramStatus;
            }
        }
        public async void refreshStatus()
        {
            var Bot = new Telegram.Bot.TelegramBotClient(bot_id);
            var iMeessage = 0;
            while (true)
            {
                var updates = await Bot.GetUpdates(iMeessage);
                var metartext = "";
                foreach (var update in updates)
                {
                    // subscribe cjimenez13@outlook.com Password12
                    if (update.Message.Type == MessageType.TextMessage && update.Message.Text.StartsWith("/subscribe"))
                    {
                        var station = update.Message.Text.Substring(update.Message.Text.Length - 4);
                        await Bot.SendChatAction(update.Message.Chat.Id, ChatAction.Typing);
                        await Task.Delay(2000);
                        var t = await Bot.SendTextMessage(update.Message.Chat.Id, metartext);
                    }

                    iMeessage = update.Id + 1;
                }
                await Task.Delay(1000);
            }
        }
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
