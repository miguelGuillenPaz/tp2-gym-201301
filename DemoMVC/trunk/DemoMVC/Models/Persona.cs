using System.Collections;
using System.ComponentModel;
using System.Web.Mvc;

namespace DemoMVC.Models
{
    public class Persona
    {
        /// <summary>
        /// Estado civil
        /// </summary>
        [DisplayName(@"Estado Civil")]
        public int EstadoCivilId { get; set; }

        /// <summary>
        /// Propiedad para DropDownList Estado Civil
        /// </summary>
        [DisplayName(@"Estado Civil")]
        public IEnumerable EstadoCivil { get; set; }


        public bool ObtenerPostulante(out Persona persona, int personaId)
        {
            try
            {
                persona = new Persona
                    {
                        EstadoCivilId = 2,
                        EstadoCivil = new SelectList(new[]
                        {
                            new SelectListItem {Text = @"Seleccione", Value = "0", Selected = true},
                            new SelectListItem {Text = @"Soltero", Value = "1"},
                            new SelectListItem {Text = @"Casado", Value = "2"},
                            new SelectListItem {Text = @"Viudo", Value = "3"},
                            new SelectListItem {Text = @"Divorciado", Value = "4"}
                        }, "Value", "Text")
                    };
                return true;
            }
            catch
            {
                persona = null;
                return false;
            }
        }

    }
}