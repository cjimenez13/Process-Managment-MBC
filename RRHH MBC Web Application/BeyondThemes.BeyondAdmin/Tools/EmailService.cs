using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace BeyondThemes.BeyondAdmin.Tools
{
    public class EmailService
    {
        public bool sendEmail(string to, string subject, string body)
        {
            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");

            smtpClient.Credentials = new System.Net.NetworkCredential("cjimenezc13@gmail.com", "120214BestDE");
            smtpClient.UseDefaultCredentials = true;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.EnableSsl = true;
            MailMessage mail = new MailMessage("cjimenezc13@outlook.com", to, subject, body);
            //mail.From = new MailAddress("info@cj", "MyWeb Site");
            //mail.To.Add(new MailAddress("info@MyWebsiteDomainName"));
            //mail.CC.Add(new MailAddress("MyEmailID@gmail.com"));
            smtpClient.Send(mail);
            return true;
        }
    }
}
