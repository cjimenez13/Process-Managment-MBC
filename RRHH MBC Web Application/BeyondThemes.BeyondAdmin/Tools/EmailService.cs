using System.Net;
using System.Net.Mail;

namespace BeyondThemes.BeyondAdmin.Tools
{
    public class EmailService
    {
        public static bool sendEmail(string to, string subject, string body)
        {
            SmtpClient smtpClient = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new System.Net.NetworkCredential("cjimenezc13@gmail.com", "120214BestDE")
            };
            MailMessage mail = new MailMessage("cjimenezc13@gmail.com", to, subject, body);
            smtpClient.Send(mail);
            return true;
        }
    }
}
