using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Html;
using System.Web.Routing;
using System.Web.UI;

namespace DemoMVC.HelperClass
{
    public static class Utils
    {
        public static MvcHtmlString CheckBoxListFor<TModel, TProperty>(this HtmlHelper<TModel> htmlHelper, Expression<Func<TModel, TProperty[]>> expression, MultiSelectList multiSelectList, object htmlAttributes = null)
        {
            //Derive property name for checkbox name
            string propertyName = ExpressionHelper.GetExpressionText(expression);

            //Get currently select values from the ViewData model
            var list = expression.Compile().Invoke(htmlHelper.ViewData.Model);

            //Convert selected value list to a List<string> for easy manipulation
            var selectedValues = new List<string>();

            if (list != null)
            {
                selectedValues = new List<TProperty>(list).ConvertAll<string>(delegate(TProperty i) { return i.ToString(); });
            }

            //Create div
            var divTag = new TagBuilder("div");
            divTag.MergeAttributes(new RouteValueDictionary(htmlAttributes), true);

            //Add checkboxes
            foreach (SelectListItem item in multiSelectList)
            {
                divTag.InnerHtml += String.Format("<div><input type=\"checkbox\" name=\"{0}\" id=\"{0}_{1}\" " +
                                                    "value=\"{1}\" {2} /><label for=\"{0}_{1}\">{3}</label></div>",
                                                    propertyName,
                                                    item.Value,
                                                    selectedValues.Contains(item.Value) ? "checked=\"checked\"" : "",
                                                    item.Text);
            }

            return MvcHtmlString.Create(divTag.ToString());
        }


        public static MvcHtmlString CheckBoxList(this HtmlHelper htmlHelper, List<SelectListItem> list, string modelCollectionName, List<int> values)
        {
            var sb = new StringBuilder();

            if (list != null)
            {
                //int i = 0;

                foreach (var l in list)
                {
                    var collectionNameIndex = String.Format("{0}:{1}", modelCollectionName, l.Value);
                    var checkBoxTag = htmlHelper.CheckBox(collectionNameIndex, values.Contains(Convert.ToInt32(l.Value)));

                    var labelTag = new TagBuilder("label");
                    //labelTag.Attributes.Add(new KeyValuePair<string, string>("for", String.Format("{0}.{1}", collectionNameIndex, "Name")));
                    labelTag.SetInnerText(l.Text);

                    //sb.Append(hiddenName);
                    //sb.Append(hiddenValue);
                    sb.Append(checkBoxTag);
                    sb.Append(labelTag);
                    sb.Append("<br/>");

                    //i++;
                }
            }

            return MvcHtmlString.Create(sb.ToString());
        }


        public static MvcHtmlString CheckBoxList(this HtmlHelper htmlHelper, List<SelectListItem> list, string modelCollectionName)
        {
            var sb = new StringBuilder();

            if (list != null)
            {
                //int i = 0;

                foreach (var l in list)
                {
                    var collectionNameIndex = String.Format("{0}:{1}", modelCollectionName, l.Value);

                    //var hiddenName = new TagBuilder("input");
                    //hiddenName.Attributes.Add(new KeyValuePair<string, string>("type", "hidden"));
                    //hiddenName.Attributes.Add(new KeyValuePair<string, string>("name", String.Format("{0}.{1}", collectionNameIndex, "Text")));
                    //hiddenName.Attributes.Add(new KeyValuePair<string, string>("value", l.Text));

                    //var hiddenValue = new TagBuilder("input");
                    //hiddenValue.Attributes.Add(new KeyValuePair<string, string>("type", "hidden"));
                    //hiddenValue.Attributes.Add(new KeyValuePair<string, string>("name", String.Format("{0}.{1}", collectionNameIndex, "Value")));
                    //hiddenValue.Attributes.Add(new KeyValuePair<string, string>("value", l.Value));

                    var checkBoxTag = htmlHelper.CheckBox(collectionNameIndex, l.Selected);

                    var labelTag = new TagBuilder("label");
                    //labelTag.Attributes.Add(new KeyValuePair<string, string>("for", String.Format("{0}.{1}", collectionNameIndex, "Name")));
                    labelTag.SetInnerText(l.Text);

                    //sb.Append(hiddenName);
                    //sb.Append(hiddenValue);
                    sb.Append(checkBoxTag);
                    sb.Append(labelTag);
                    sb.Append("<br/>");

                    //i++;
                }
            }

            return MvcHtmlString.Create(sb.ToString());
        }

        public static void ShowMessage(ViewDataDictionary viewData, string message)
        {
            var s = @"<script language='javascript'>$(function(){$(""<div>" + message + @"</div>"").dialog({modal:true, buttons:{Aceptar: function(){$(this).dialog('close');}}});});</script>";
            viewData["message"] = s;
        }
        public static void ShowMessage(ViewDataDictionary viewData, string message,string redirect)
        {
            var s = @"<script language='javascript'>$(function(){$(""<div>" + message + @"</div>"").dialog({modal:true, buttons:{Aceptar: function(){$(this).dialog('close');window.location.href='"+redirect+@"';}}});});</script>";
            viewData["message"] = s;
        }
    }
}