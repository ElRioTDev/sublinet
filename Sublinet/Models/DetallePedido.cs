using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sublinet.Models
{
    public class DetallePedido
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int DetalleID { get; set; }
        
        [Required]
        public int PedidoID { get; set; }
        
        [Required]
        public int ProductoID { get; set; }
        
        [Required]
        [Range(1, 100, ErrorMessage = "La cantidad debe ser entre 1 y 100")]
        public int Cantidad { get; set; }
        
        [Required]
        [Range(0.01, 1000, ErrorMessage = "El precio unitario debe ser mayor a 0")]
        public decimal PrecioUnitario { get; set; }
        
        [Required]
        [Range(0.01, 10000, ErrorMessage = "El subtotal debe ser mayor a 0")]
        public decimal Subtotal { get; set; }
        
        // Navigation properties
        public virtual Pedido? Pedido { get; set; }
        public virtual Producto? Producto { get; set; }
    }
}