using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Sublinet.Models;
using System.Diagnostics;

namespace Sublinet.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly AppDbContext _context;

        public HomeController(ILogger<HomeController> logger, AppDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var productosDestacados = await _context.Productos
                .Include(p => p.Categoria)
                .Where(p => p.Activo && p.Stock > 0)
                .OrderByDescending(p => p.FechaCreacion)
                .Take(6)
                .ToListAsync();

            return View(productosDestacados);
        }

        public async Task<IActionResult> Tienda(string? categoria = null, string? talla = null, string? color = null)
        {
            var productosQuery = _context.Productos
                .Include(p => p.Categoria)
                .Where(p => p.Activo && p.Stock > 0);

            if (!string.IsNullOrEmpty(categoria))
            {
                productosQuery = productosQuery.Where(p => p.Categoria != null && p.Categoria.Nombre == categoria);
            }

            if (!string.IsNullOrEmpty(talla))
            {
                productosQuery = productosQuery.Where(p => p.Talla == talla);
            }

            if (!string.IsNullOrEmpty(color))
            {
                productosQuery = productosQuery.Where(p => p.Color.Contains(color));
            }

            var productos = await productosQuery.ToListAsync();
            
            ViewBag.Categorias = await _context.Categorias.Where(c => c.Activo).ToListAsync();
            ViewBag.Tallas = new List<string> { "XS", "S", "M", "L", "XL", "XXL" };
            ViewBag.Colores = await _context.Productos
                .Where(p => p.Activo)
                .Select(p => p.Color)
                .Distinct()
                .ToListAsync();

            return View(productos);
        }

        public async Task<IActionResult> DetalleProducto(int id)
        {
            var producto = await _context.Productos
                .Include(p => p.Categoria)
                .FirstOrDefaultAsync(p => p.ProductoID == id && p.Activo);

            if (producto == null)
            {
                return NotFound();
            }

            return View(producto);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}