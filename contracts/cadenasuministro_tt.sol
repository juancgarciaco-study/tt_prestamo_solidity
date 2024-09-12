// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract CadenaSuministro {
    // Estructura para representar un producto
    struct Producto {
        string nombreProducto;
        address propietario;
        uint256 estado; // 0: en tránsito, 1: entregado
    }

    // Arreglo de productos
    Producto[] public productos;

    // Mapeo para almacenar la cantidad de productos por producto
    mapping(uint256 => uint256) public cantidadProductos;
    mapping(uint256 => uint256) public cantidadProductosEntregados;

    // Dirección del propietario del contrato
    address public propietario;

    // Evento para registrar la entrega de un producto
    event ProductoEntregado(
        uint256 indexed productId,
        address indexed propietario
    );

    // Constructor que inicializa el propietario del contrato
    constructor() {

/**
 * Marks a product as delivered.
 *
 * @param _productId The ID of the product to deliver.
 *
 * Requirements:
 * - Only the contract owner can call this function.
 * - The product must exist and not be already delivered.
 *
 * Effects:
 * - Updates the product's status to delivered.
 * - Increments the quantity of delivered products.
 *
 * Emits:
 * - A `ProductoEntregado` event with the product ID and owner's address.
 */        propietario = msg.sender;
    }
       
       /**
        * Marks a product as delivered.
        *
        * @notice Only the contract owner can call this function.
        * @param _productId The ID of the product to deliver.
        */
    // Función para marcar un producto como entregado
    function entregarProducto(uint256 _productId) public {
        require(
            msg.sender == propietario,
            "Solo el propietario puede llamar a esta funcion"
        );
        require(_productId <= productos.length, "ID de producto no valido");

        Producto storage producto = productos[_productId - 1];
        require(producto.estado == 0, "El producto ya ha sido entregado");

        producto.propietario = propietario;
        producto.estado = 1;

        cantidadProductosEntregados[_productId] += 1;

        emit ProductoEntregado(_productId, propietario);
    }

    // Funcion para agregar mas cantidad a un producto existente
    function agregarProductoExistente(uint256 _productId, uint256 _cantidad)
        public
    {
        require(
            msg.sender == propietario,
            "Solo el propietario puede llamar a esta funcion"
        );
        require(
            _productId <= productos.length && _cantidad > 0,
            "ID de producto o cantidad no validos"
        );

        cantidadProductos[_productId] += _cantidad;
    }

    // Función para agregar un nuevo producto con un nuevo ID
    function agregarNuevoProducto(
        string memory _nombreProducto,
        uint256 _cantidad
    ) public {
        require(
            msg.sender == propietario,
            "Solo el propietario puede llamar a esta funcion"
        );
        require(_cantidad > 0, "Cantidad no valida");

        productos.push(Producto(_nombreProducto, address(0), 0));
        cantidadProductos[productos.length] = _cantidad;
        cantidadProductosEntregados[productos.length] = 0;

    }

    // Función para obtener la cantidad de productos por producto
    function verProductos()
        public
        view
        returns (
            uint256[] memory,
            string[] memory,
            uint256[] memory,
            uint256[] memory
        )
    {
        uint256[] memory ids = new uint256[](productos.length);
        string[] memory nombres = new string[](productos.length);
        uint256[] memory cantidades = new uint256[](productos.length);
        uint256[] memory cantidadesEntregadas = new uint256[](productos.length);

        for (uint256 i = 0; i < productos.length; i++) {
            ids[i] = i + 1;
            nombres[i] = productos[i].nombreProducto;
            cantidades[i] = cantidadProductos[i + 1];
            cantidadesEntregadas[i] = cantidadProductosEntregados[i + 1];
        }

        return (ids, nombres, cantidades, cantidadesEntregadas);
    }

    function zero() public pure returns (uint256) {
        return 0;
    }
}
