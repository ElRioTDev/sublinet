-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS SublinetDB;
USE SublinetDB;

-- Tabla de Categorías
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion TEXT,
    FechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Productos (Camisas)
CREATE TABLE Productos (
    ProductoID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(200) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10,2) NOT NULL,
    PrecioDescuento DECIMAL(10,2) NULL,
    CategoriaID INT,
    Talla ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL') NOT NULL,
    Color VARCHAR(50) NOT NULL,
    Material VARCHAR(100),
    Stock INT DEFAULT 0,
    ImagenURL VARCHAR(500),
    FechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Tabla de Clientes
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefono VARCHAR(20),
    Direccion TEXT,
    Ciudad VARCHAR(100),
    CodigoPostal VARCHAR(20),
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE
);

-- Tabla de Pedidos
CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('Pendiente', 'Confirmado', 'Enviado', 'Entregado', 'Cancelado') DEFAULT 'Pendiente',
    Total DECIMAL(10,2) NOT NULL,
    DireccionEnvio TEXT,
    MetodoPago ENUM('Tarjeta', 'PayPal', 'Transferencia') DEFAULT 'Tarjeta',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabla de Detalles de Pedido
CREATE TABLE DetallesPedido (
    DetalleID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProductoID INT,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- Tabla de Usuarios (para el admin de la aplicación)
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Rol ENUM('Admin', 'Usuario') DEFAULT 'Usuario',
    FechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN DEFAULT TRUE
);

-- Insertar datos de ejemplo

-- Categorías
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Camisas Formales', 'Camisas elegantes para ocasiones formales y de negocios'),
('Camisas Casuales', 'Camisas cómodas para uso diario y ocasiones informales'),
('Camisas Deportivas', 'Camisas técnicas para actividades deportivas'),
('Camisas de Manga Larga', 'Camisas con mangas largas para todo clima'),
('Camisas de Manga Corta', 'Camisas frescas para climas cálidos');

-- Productos
INSERT INTO Productos (Nombre, Descripcion, Precio, PrecioDescuento, CategoriaID, Talla, Color, Material, Stock, ImagenURL) VALUES
('Camisa Oxford Blanca', 'Camisa formal de algodón Oxford, perfecta para la oficina', 45.99, 39.99, 1, 'M', 'Blanco', 'Algodón 100%', 50, '/images/camisa-oxford-blanca.jpg'),
('Camisa Lino Azul', 'Camisa casual de lino, ideal para verano', 35.50, NULL, 2, 'L', 'Azul', 'Lino 100%', 30, '/images/camisa-lino-azul.jpg'),
('Camisa Deportiva Negra', 'Camisa técnica para running y gym', 29.99, 24.99, 3, 'S', 'Negro', 'Poliester 90%, Elastano 10%', 75, '/images/camisa-deportiva-negra.jpg'),
('Camisa Manga Larga Rayas', 'Camisa clásica de manga larga con rayas', 42.00, 36.00, 4, 'XL', 'Azul Marino/Rayas Blancas', 'Algodón 100%', 40, '/images/camisa-rayas-ml.jpg'),
('Camisa Polo Verde', 'Camisa polo casual para el día a día', 32.99, NULL, 2, 'M', 'Verde', 'Piqué de algodón', 60, '/images/camisa-polo-verde.jpg'),
('Camisa Formal Negra', 'Camisa elegante para eventos especiales', 49.99, 44.99, 1, 'L', 'Negro', 'Algodón Premium', 25, '/images/camisa-formal-negra.jpg'),
('Camisa Casual Roja', 'Camisa vibrante para looks casuales', 28.50, NULL, 2, 'S', 'Rojo', 'Algodón 100%', 45, '/images/camisa-casual-roja.jpg'),
('Camisa Deportiva Azul', 'Camisa deportiva con tecnología dry-fit', 34.99, 29.99, 3, 'M', 'Azul', 'Poliester 85%, Elastano 15%', 55, '/images/camisa-deportiva-azul.jpg');

-- Clientes de ejemplo
INSERT INTO Clientes (Nombre, Apellido, Email, Telefono, Direccion, Ciudad, CodigoPostal) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '+34 600 123 456', 'Calle Principal 123', 'Madrid', '28001'),
('María', 'Gómez', 'maria.gomez@email.com', '+34 600 654 321', 'Avenida Central 456', 'Barcelona', '08001'),
('Carlos', 'López', 'carlos.lopez@email.com', '+34 600 789 012', 'Plaza Mayor 789', 'Valencia', '46001'),
('Ana', 'Martínez', 'ana.martinez@email.com', '+34 600 345 678', 'Calle Secundaria 321', 'Sevilla', '41001');

-- Usuario admin con contraseña válida: "Admin123!"
INSERT INTO Usuarios (Email, PasswordHash, Nombre, Rol) VALUES
('admin@sublinet.com', '$2a$10$rLAa1s5Q7qQCqKkF5Y2Zz.EBzrQeG9aJd8mCvL8sN2pV1wR3tY6dC', 'Administrador Principal', 'Admin'),
('ventas@sublinet.com', '$2a$10$rLAa1s5Q7qQCqKkF5Y2Zz.EBzrQeG9aJd8mCvL8sN2pV1wR3tY6dC', 'Manager Ventas', 'Admin');

-- Usuario normal de ejemplo
INSERT INTO Usuarios (Email, PasswordHash, Nombre, Rol) VALUES
('cliente@email.com', '$2a$10$rLAa1s5Q7qQCqKkF5Y2Zz.EBzrQeG9aJd8mCvL8sN2pV1wR3tY6dC', 'Cliente Demo', 'Usuario');

-- Pedidos de ejemplo
INSERT INTO Pedidos (ClienteID, FechaPedido, Estado, Total, DireccionEnvio, MetodoPago) VALUES
(1, '2024-01-15 10:30:00', 'Entregado', 85.98, 'Calle Principal 123, Madrid', 'Tarjeta'),
(2, '2024-01-16 14:20:00', 'Enviado', 35.50, 'Avenida Central 456, Barcelona', 'PayPal'),
(3, '2024-01-17 09:15:00', 'Confirmado', 64.99, 'Plaza Mayor 789, Valencia', 'Transferencia');

-- Detalles de pedidos
INSERT INTO DetallesPedido (PedidoID, ProductoID, Cantidad, PrecioUnitario, Subtotal) VALUES
(1, 1, 1, 39.99, 39.99),  -- Camisa Oxford Blanca en oferta
(1, 3, 1, 24.99, 24.99),  -- Camisa Deportiva Negra en oferta
(1, 6, 1, 20.00, 20.00),  -- Envío (simulado)
(2, 2, 1, 35.50, 35.50),  -- Camisa Lino Azul
(3, 4, 1, 36.00, 36.00),  -- Camisa Manga Larga Rayas en oferta
(3, 7, 1, 28.99, 28.99);  -- Camisa Casual Roja

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_productos_categoria ON Productos(CategoriaID);
CREATE INDEX idx_productos_activo ON Productos(Activo);
CREATE INDEX idx_pedidos_cliente ON Pedidos(ClienteID);
CREATE INDEX idx_pedidos_fecha ON Pedidos(FechaPedido);
CREATE INDEX idx_detalles_pedido ON DetallesPedido(PedidoID);
CREATE INDEX idx_clientes_email ON Clientes(Email);
CREATE INDEX idx_usuarios_email ON Usuarios(Email);

-- Vistas útiles

-- Vista para productos disponibles
CREATE OR REPLACE VIEW ProductosDisponibles AS
SELECT 
    p.ProductoID,
    p.Nombre,
    p.Descripcion,
    p.Precio,
    p.PrecioDescuento,
    c.Nombre as Categoria,
    p.Talla,
    p.Color,
    p.Stock,
    p.ImagenURL,
    CASE 
        WHEN p.PrecioDescuento IS NOT NULL THEN p.PrecioDescuento
        ELSE p.Precio
    END as PrecioFinal
FROM Productos p
INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID
WHERE p.Activo = TRUE AND p.Stock > 0;

-- Vista para reporte de ventas
CREATE OR REPLACE VIEW ReporteVentas AS
SELECT 
    p.PedidoID,
    c.Nombre as ClienteNombre,
    c.Apellido as ClienteApellido,
    p.FechaPedido,
    p.Total,
    p.Estado,
    COUNT(dp.DetalleID) as TotalProductos
FROM Pedidos p
INNER JOIN Clientes c ON p.ClienteID = c.ClienteID
LEFT JOIN DetallesPedido dp ON p.PedidoID = dp.PedidoID
GROUP BY p.PedidoID, c.Nombre, c.Apellido, p.FechaPedido, p.Total, p.Estado;

-- Vista para inventario bajo
CREATE OR REPLACE VIEW InventarioBajo AS
SELECT 
    p.ProductoID,
    p.Nombre,
    p.Stock,
    c.Nombre as Categoria,
    p.Talla,
    p.Color
FROM Productos p
INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID
WHERE p.Stock < 10 AND p.Activo = TRUE;

-- Procedimiento almacenado para actualizar stock
DELIMITER //
CREATE PROCEDURE ActualizarStock(
    IN p_ProductoID INT,
    IN p_Cantidad INT,
    OUT p_Resultado VARCHAR(100)
)
BEGIN
    DECLARE stock_actual INT;
    
    SELECT Stock INTO stock_actual FROM Productos WHERE ProductoID = p_ProductoID;
    
    IF stock_actual IS NULL THEN
        SET p_Resultado = 'Producto no encontrado';
    ELSEIF (stock_actual + p_Cantidad) < 0 THEN
        SET p_Resultado = 'Stock insuficiente';
    ELSE
        UPDATE Productos 
        SET Stock = Stock + p_Cantidad 
        WHERE ProductoID = p_ProductoID;
        SET p_Resultado = 'Stock actualizado correctamente';
    END IF;
END//
DELIMITER ;

-- Mostrar información de la base de datos creada
SELECT 
    'Base de datos SublinetDB creada exitosamente' as Mensaje,
    COUNT(*) as TotalProductos,
    (SELECT COUNT(*) FROM Categorias) as TotalCategorias,
    (SELECT COUNT(*) FROM Clientes) as TotalClientes,
    (SELECT COUNT(*) FROM Usuarios) as TotalUsuarios;

-- Mostrar credenciales de acceso
SELECT 
    'CREDENCIALES DE ACCESO' as Tipo,
    Email as Usuario,
    'Admin123!' as Contraseña,
    Rol as Perfil
FROM Usuarios;