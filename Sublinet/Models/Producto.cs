using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sublinet.Models
{
    public class Producto
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int ProductoID { get; set; }

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [StringLength(200, ErrorMessage = "El nombre no puede exceder 200 caracteres")]
        public string Nombre { get; set; } = string.Empty;

        public string? Descripcion { get; set; }

        [Required(ErrorMessage = "El precio es obligatorio")]
        [Range(0.01, 1000, ErrorMessage = "El precio debe ser mayor a 0")]
        public decimal Precio { get; set; }

        public decimal? PrecioDescuento { get; set; }

        [Required(ErrorMessage = "La categoría es obligatoria")]
        public int CategoriaID { get; set; }

        [Required(ErrorMessage = "La talla es obligatoria")]
        public string Talla { get; set; } = string.Empty;

        [Required(ErrorMessage = "El color es obligatorio")]
        public string Color { get; set; } = string.Empty;

        public string? Material { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "El stock no puede ser negativo")]
        public int Stock { get; set; }

        public string? ImagenURL { get; set; }
        public DateTime FechaCreacion { get; set; }
        public bool Activo { get; set; }

        // Navigation property
        public virtual Categoria? Categoria { get; set; }
    }
}