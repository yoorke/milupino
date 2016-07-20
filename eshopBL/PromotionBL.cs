using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopBE;
using eshopDL;
using System.Data;

namespace eshopBL
{
    public class PromotionBL
    {
        public int SavePromotion(Promotion promotion)
        {
            PromotionDL promotionDL=new PromotionDL();
            if (promotion.PromotionID > 0)
                return promotionDL.UpdatePromotion(promotion);
            else
                return promotionDL.SavePromotion(promotion);
        }

        public List<Promotion> GetPromotions(bool allSelection, bool? showOnFirstPage)
        {
            PromotionDL promotionDL = new PromotionDL();
            List<Promotion> promotions = promotionDL.GetPromotions(showOnFirstPage);

            if (allSelection && promotions != null)
                promotions.Insert(0, new Promotion(0, "Odaberi", 0, string.Empty, 0, false, DateTime.MinValue, DateTime.Now));

            return promotions;
        }

        public Promotion GetPromotion(int promotionID)
        {
            PromotionDL promotionDL = new PromotionDL();
            return promotionDL.GetPromotion(promotionID);
        }

        public int DeletePromotion(int promotionID)
        {
            PromotionDL promotionDL = new PromotionDL();
            return promotionDL.DeletePromotion(promotionID);
        }

        public DataTable GetActive()
        {
            return new PromotionDL().GetActive();
        }
    }
}
