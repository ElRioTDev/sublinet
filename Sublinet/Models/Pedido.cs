using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Sublinet.Models
{
    public class Pedido
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int PedidoID { get; set; }
        
        [Required]
        public int ClienteID { get; set; }
        
        public DateTime FechaPedido { get; set; }
        
        [Required]
        public string Estado { get; set; } = "Pendiente";
        
        [Required]
        [Range(0.01, 10000, ErrorMessage = "El total debe ser mayor a 0")]
        public decimal Total { get; set; }
        
        public string? DireccionEnvio { get; set; }
        
        public string? MetodoPago { get; set; } = "Tarjeta";
        
        // Navigation properties
        public virtual Cliente? Cliente { get; set; }
        public virtual ICollection<DetallePedido> DetallesPedido { get; set; } = new List<DetallePedido>();
    }
}