using Microsoft.EntityFrameworkCore;

namespace Sublinet.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<Producto> Productos { get; set; } = null!;
        public DbSet<Categoria> Categorias { get; set; } = null!;
        public DbSet<Cliente> Clientes { get; set; } = null!;
        public DbSet<Pedido> Pedidos { get; set; } = null!;
        public DbSet<DetallePedido> DetallesPedido { get; set; } = null!;
        public DbSet<Usuario> Usuarios { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configurar relaciones
            modelBuilder.Entity<Producto>()
                .HasOne(p => p.Categoria)
                .WithMany(c => c.Productos)
                .HasForeignKey(p => p.CategoriaID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Pedido>()
                .HasOne(p => p.Cliente)
                .WithMany()
                .HasForeignKey(p => p.ClienteID)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<DetallePedido>()
                .HasOne(dp => dp.Pedido)
                .WithMany(p => p.DetallesPedido)
                .HasForeignKey(dp => dp.PedidoID)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DetallePedido>()
                .HasOne(dp => dp.Producto)
                .WithMany()
                .HasForeignKey(dp => dp.ProductoID)
                .OnDelete(DeleteBehavior.Restrict);

            // Configurar valores por defecto
            modelBuilder.Entity<Producto>()
                .Property(p => p.FechaCreacion)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<Categoria>()
                .Property(c => c.FechaCreacion)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<Cliente>()
                .Property(c => c.FechaRegistro)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<Pedido>()
                .Property(p => p.FechaPedido)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");

            modelBuilder.Entity<Usuario>()
                .Property(u => u.FechaCreacion)
                .HasDefaultValueSql("CURRENT_TIMESTAMP");
        }
    }
}