using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using eshopDL;
using eshopBE;
using System.Data;

namespace eshopBL
{
    public class SliderBL
    {
        public int SaveSlider(Slider slider)
        {
            SliderDL sliderDL = new SliderDL();
            return (slider.SliderID > 0) ? sliderDL.UpdateSlider(slider) : sliderDL.SaveSlider(slider);
        }

        public Slider GetSlider(int sliderID)
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.GetSlider(sliderID);
        }

        public DataTable GetSliders()
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.GetSliders();
        }

        public int SaveSliderItem(SliderItem item)
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.SaveSliderItem(item);
        }

        public int DeleteSliderItem(int sliderItemID)
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.DeleteSliderItem(sliderItemID);
        }

        public int DeleteSlider(int sliderID)
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.DeleteSlider(sliderID);
        }

        public void ReorderSliderItems(int sliderItemID, int index, int sliderID)
        {
            SliderDL sliderDL = new SliderDL();
            sliderDL.ReorderSliderItem(sliderItemID, index, sliderID);
        }

        public List<SliderItem> GetSliderItems(int sliderID)
        {
            SliderDL sliderDL = new SliderDL();
            return sliderDL.getSliderItems(sliderID);
        }
    }
}
