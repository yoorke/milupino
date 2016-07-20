using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace eshopBE
{
    public class Coupon
    {
        private int _couponID;
        private string _name;
        private double _discount;
        private string _code;

        public Coupon()
        {
        }

        public Coupon(int couponID, string name, double discount, string code)
        {
            _couponID = couponID;
            _name = name;
            _discount = discount;
            _code = code;
        }

        public int CouponID
        {
            get { return _couponID; }
            set { _couponID = value; }
        }

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public double Discount
        {
            get { return _discount; }
            set { _discount = value; }
        }

        public string Code
        {
            get { return _code; }
            set { _code = value; }
        }
    }
}
