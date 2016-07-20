using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopDL;
using System.Data;
using eshopBE;
using System.Web.Security;
using System.Security.Cryptography;
using eshopUtilities;

namespace eshopBL
{
    public class UserBL
    {
        public static DataTable GetUsers()
        {
            return UserDL.GetUsers();
        }

        public static int DeleteUser(int userID)
        {
            return UserDL.DeleteUser(userID);
        }

        public static DataTable GetUserTypes()
        {
            return UserDL.GetUserTypesDT();
        }

        public static User GetUser(int userID, string username)
        {
            return UserDL.GetUser(userID, username);
        }

        public static DataTable GetUser(string username, int userID)
        {
            return UserDL.GetUser(username, userID);
        }

        public static int SaveUser(string firstName, string lastName, string username, string password, string email, string address, string city, string phone, string userType)
        {
            string salt = getSalt();
            string plainPassword;
            password = password == string.Empty ? createPassword() : password;
            plainPassword = password;
            password = hashPassword(password, salt);
            int status = UserDL.SaveUser(firstName, lastName, username, password, email, address, city, phone, userType, salt);
            if (status > 0)
                Common.SendUserCreatedConfirmationMail(username, plainPassword);
            return status;
        }

        private static string createPassword()
        {
            return Membership.GeneratePassword(8, 0);
        }

        public static string hashPassword(string password, string salt)
        {
            System.Text.UnicodeEncoding ue = new UnicodeEncoding();
            byte[] uePassword = ue.GetBytes(password);
            byte[] retVal = null;
            

            HMACSHA1 SHA1KeyedHasher = new HMACSHA1();
            SHA1KeyedHasher.Key = ue.GetBytes(salt);
            retVal = SHA1KeyedHasher.ComputeHash(uePassword);

            return Convert.ToBase64String(retVal);
        }

        public static string getSalt()
        {
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] random = new byte[32];
            rng.GetBytes(random);

            return Convert.ToBase64String(random);
        }

        public static string GetSalt(string username)
        {
            return UserDL.GetUserSalt(username);
        }
    }
}
