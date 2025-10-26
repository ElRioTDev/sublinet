using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sublinet.Models
{
    public class Categoria
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int CategoriaID { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(100, ErrorMessage = "El nombre no puede exceder 100 caracteres")]
        public string Nombre { get; set; } = string.Empty;

        public string? Descripcion { get; set; }

        public DateTime FechaCreacion { get; set; }
        public bool Activo { get; set; }

        // Navigation property
        public virtual ICollection<Producto> Productos { get; set; } = new List<Producto>();
    }
}