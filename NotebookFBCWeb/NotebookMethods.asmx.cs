using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace NotebookFBCWeb
{
    /// <summary>
    /// Сводное описание для NotebookMethods
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    [System.Web.Script.Services.ScriptService]
    public class NotebookMethods : System.Web.Services.WebService
    {
        

        [WebMethod]
        public string GetUsers()
        {
            List<UsersInfo> usersList = new List<UsersInfo>();

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("select * from TestTableFBC", con);

                con.Open();

                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    UsersInfo users = new UsersInfo();
                    users.Id = Convert.ToInt32(rdr["ID"]);
                    users.Name = rdr["Name_User"].ToString();
                    users.Phone = rdr["Phone_User"].ToString();
                    users.Email = rdr["Email_User"].ToString();
                    users.Gender = rdr["Gender_User"].ToString();


                    usersList.Add(users);
                }
                con.Close();
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(usersList);
            //Context.Response.Write(js.Serialize(usersList));
        }
        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string DeleteUsers(UsersInfo user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<UsersInfo> Users = new List<UsersInfo>();
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            using (SqlCommand cmd = new SqlCommand("delete from TestTableFBC where ID = @Id", con)) 
            {
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = user.Id;
                cmd.ExecuteNonQuery();
            }
            con.Close();
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(new { status = true, });
            
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string AddUsers(UsersInfo user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<UsersInfo> Users = new List<UsersInfo>();
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            using (SqlCommand cmd = new SqlCommand("insert into TestTableFBC (Name_User, Phone_User, Email_User, Gender_User) VALUES (@Name, @Phone, @Email, @Gender)", con))
            {
                cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = user.Name;
                cmd.Parameters.Add("@Phone", SqlDbType.VarChar).Value = user.Phone;
                cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = user.Email;
                cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = user.Gender;
                cmd.ExecuteNonQuery();
            }
            con.Close();
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(new { status = true, });
            
        }

        [System.Web.Services.WebMethod]
        [System.Web.Script.Services.ScriptMethod]
        public string ChangeUsers(UsersInfo user)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            List<UsersInfo> Users = new List<UsersInfo>();
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            using (SqlCommand cmd = new SqlCommand("UPDATE TestTableFBC SET Name_User=@Name, Phone_User=@Phone, Email_User=@Email, Gender_User=@Gender where ID = @Id", con)) 
            {
                cmd.Parameters.Add("@Name", SqlDbType.VarChar).Value = user.Name;
                cmd.Parameters.Add("@Phone", SqlDbType.VarChar).Value = user.Phone;
                cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = user.Email;
                cmd.Parameters.Add("@Gender", SqlDbType.VarChar).Value = user.Gender;
                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = user.Id;
                cmd.ExecuteNonQuery();
            }
            con.Close();
            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(new { status = true, });
            
        }
    }
}
