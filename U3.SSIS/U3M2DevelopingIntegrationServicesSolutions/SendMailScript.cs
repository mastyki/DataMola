

#region Namespaces
using System;
using System.Data;
using Microsoft.SqlServer.Dts.Runtime;
using System.Windows.Forms;
using System.Net;
using System.Net.Mail;
#endregion

namespace ST_2bc4be821f084c60bea9a623ed20f369
{
   
	[Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute]
	public partial class ScriptMain : Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase
	{
      
		public void Main()
		{
            String SendMailFrom = Dts.Variables["User::EmailSendFrom"].Value.ToString();
            String SendMailTo = Dts.Variables["User::EmailSendFrom"].Value.ToString();
            String SendMailSubject = Dts.Variables["User::EmailSubject"].Value.ToString();
            String SendMailAppPassword = Dts.Variables["User::EmailAppPassword"].Value.ToString();
            String SendMailBody = "Number of the exported rows is" + " " + Dts.Variables["User::RowCount"].Value.ToString();
            //+ " " + Dts.Variables["User::RowCount"].Value.ToString()
            try
            {
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com", 587);
                SmtpServer.DeliveryMethod = SmtpDeliveryMethod.Network;
                MailMessage email = new MailMessage();
                // START
                email.From = new MailAddress(SendMailFrom);
                email.To.Add(SendMailTo);
                email.CC.Add(SendMailFrom);
                email.Subject = SendMailSubject;
                email.Body = SendMailBody;
                //END
                SmtpServer.Timeout = 5000;
                SmtpServer.EnableSsl = true;
                SmtpServer.UseDefaultCredentials = false;
                SmtpServer.Credentials = new NetworkCredential(SendMailFrom, SendMailAppPassword);
                SmtpServer.Send(email);

                MessageBox.Show("Email was Successfully Sent !!!");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString());
            }
            Dts.TaskResult = (int)ScriptResults.Success;
		}

        #region ScriptResults declaration
    
        enum ScriptResults
        {
            Success = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Success,
            Failure = Microsoft.SqlServer.Dts.Runtime.DTSExecResult.Failure
        };
        #endregion

	}
}