using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopBE;
using eshopDL;

namespace eshopBL
{
    public class CouponBL
    {
        public Coupon GetCoupon(string code)
        {
            CouponDL couponDL = new CouponDL();
            return couponDL.GetCoupon(code);
        }
    }
}
