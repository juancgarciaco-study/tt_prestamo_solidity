// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol";
import "hardhat/console.sol";

import "/contracts/cadenasuministro_tt.sol";

contract CadenaSuministro_tt_test {
    CadenaSuministro foo;

    function beforeAll() public {
        // <instantiate contract>
        foo = new CadenaSuministro();

        Assert.equal(foo.zero(), 0, "foo.Zero should be equal to 0");
    }

    function testProductAdding() public {
        foo.agregarNuevoProducto("Product 1", 10);
        (uint256[] memory _ids, , uint256[] memory _counts, ) = foo.verProductos();
        Assert.equal(_ids[0], 1, "_ids[0] should be equal to 1");
        Assert.equal(_counts[0], 10, "_counts[0] should be equal to 10");
    }

    function testProductDelivery() public {
        foo.agregarNuevoProducto("Product 2", 18);
        foo.entregarProducto(2);
        (
            uint256[] memory _ids,
            ,
            uint256[] memory _counts,
            uint256[] memory _statuses
        ) = foo.verProductos();

        Assert.equal(uint256(_ids[1]), 2, "_ids[1] should be equal to 2");
        // console.log(_ids[1]);
        Assert.equal(_counts[1], 18, "_counts[1] should be equal to 18");
        // console.log(_counts[1]);
        Assert.equal(_statuses[1], 1, "_statuses[1] should be equal to 1");
        // console.log(_statuses[1]);
    }

    function testExistingProductQuantity() public {
        foo.agregarNuevoProducto("Product 3", 22);

        // try foo.entregarProducto(3) {
        //     console.log("cantidades entregadas");
        // } catch Error(string memory reason) {
        //     console.log(reason);
        //     Assert.ok(false, string(abi.encodePacked("Entregando producto: -> ", reason)));
        // }

        /* Agregar a producto */
        try foo.agregarProductoExistente(3, 11) {
            console.log("cantidades agregadas");
        } catch Error(string memory reason) {
            console.log(reason);
            Assert.ok(
                false,
                string(
                    abi.encodePacked(
                        "Agregando a producto existente: -> ",
                        reason
                    )
                )
            );
        }
        /* Entregar producto */
        try foo.entregarProducto(3) {
            console.log("cantidades entregadas");
        } catch Error(string memory reason) {
            console.log(reason);
            Assert.ok(
                false,
                string(abi.encodePacked("Entregando producto: -> ", reason))
            );
        }

        (
            uint256[] memory _ids,
            ,
            uint256[] memory _counts,
            uint256[] memory _statuses
        ) = foo.verProductos();
        
        Assert.equal(_ids[2], 3, "_ids[2] should be equal to 1");
        // console.log(_ids[2]);
        Assert.equal(_counts[2], 33, "_counts[2] should be equal to 33");
        // console.log(_counts[2]);
        Assert.equal(
            uint256(_statuses[2]),
            uint256(1),
            "_statuses[2] should be equal to 0"
        );
        // console.log(_statuses[2]);

    }

    /*
    function testOwnerRestrictions() public{
        CadenaSuministro otherContract = CadenaSuministro.at(cadenaSuministro.address);
        otherContract.agregarNuevoProducto(1, "Product 1", 10);
        //assert(false);
        try {
            otherContract.agregarNuevoProducto(1, "Product 1", 10);
            assert(false, "Expected revert");
        } catch (error) {
            assert(error == "Only the owner can add a product");
        }
    }
    */
}
