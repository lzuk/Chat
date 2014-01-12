using System;
using System.Collections;
using System.Data.SqlClient;
using System.Web.Security;

namespace Chat.Chat
{
    public class DatabaseAccessor
    {
        private static DatabaseAccessor databaseAccessor = null;
        private static string connectionString;
        public static DatabaseAccessor Instance
        {
            get { return databaseAccessor ?? (databaseAccessor = new DatabaseAccessor()); }
        }
        private DatabaseAccessor()
        {
            connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MessagesService"].ConnectionString;
        }
        public void SaveMsgToDatabase(MembershipUser sender, MembershipUser receiver, string message)
        {
            using (SqlConnection connection = new SqlConnection(connectionString)) 
                //invoking dispose on connection will not close it, only mark as free and return to connection pool
            {
                using (SqlCommand command = new SqlCommand("INSERT INTO Messages (SenderID, ReceiverID, Time, Message) VALUES (@sender, @receiver, @time, @message)",
                    connection))
                {
                    Guid senderG = (Guid)sender.ProviderUserKey;
                    command.Parameters.AddWithValue("@sender", senderG);

                    object receiverG;
                    if (receiver == null)
                    {
                        receiverG = DBNull.Value;
                    }
                    else
                    {
                        receiverG = (Guid)receiver.ProviderUserKey;
                    }
                    command.Parameters.AddWithValue("@receiver", receiverG);
                    command.Parameters.AddWithValue("@time", DateTime.Now);
                    command.Parameters.AddWithValue("@message", message);
                    try{
                        connection.Open();
                        command.ExecuteNonQuery();
                    }catch(Exception e){

                    }
                }
            }
        }
        public void SaveMsgToDatabase(MembershipUser sender, string message)
        {
            SaveMsgToDatabase(sender, null, message);
        }
        public IEnumerable LastMessages(MembershipUser receiver, int limit)
        {
            ArrayList results = new ArrayList();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("SELECT SenderID, ReceiverID, Time, Message FROM Messages WHERE ReceiverID=@receiver OR ReceiverID IS NULL", connection))
                {
                    command.Parameters.AddWithValue("@receiver", receiver.ProviderUserKey);
                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        while(reader.Read()){
                            Message msg = new Message();
                            msg.Sender = Membership.GetUser(new Guid(reader.GetString(0)));
                            if (!reader.IsDBNull(1))
                            {
                                msg.Receiver = Membership.GetUser(new Guid(reader.GetString(1))); //priv msg
                            }

                            DateTime dateTime;
                            if (DateTime.TryParse(reader["Time"].ToString(), out dateTime)){
                                msg.DateTime = dateTime;
                            }

                            msg.Msg = reader.GetString(3);
                            results.Add(msg);
                        }
                    }catch(Exception e)
                    {

                    }
                }
            }
            return results;
        }
    }
    public class Message
    {
        public MembershipUser Sender { get; set; }
        public MembershipUser Receiver { get; set; }
        public DateTime DateTime { get; set; }
        public string Msg { get; set; }
        public bool Private
        {
            get
            {
                return Sender !=null && Receiver != null;
            }
        }
    }
}