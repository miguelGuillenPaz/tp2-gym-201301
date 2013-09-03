using System.Collections.Generic;

namespace GYM.SIG.Entity.Generics
{
    public class GenericDouble<T, TQ> where T : class, new()
    {
        public GenericDouble(T value, IList<TQ> list)
        {
            Value = value;
            List = list;
        }

        public T Value { get; set; }

        public IList<TQ> List { get; set; }
    }
}
