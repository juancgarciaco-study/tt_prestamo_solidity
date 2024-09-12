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
        //(uint256[] memory _ids, string[] memory _names, uint256[] memory _counts) = foo.verProductos();

        (uint256[] memory _ids, , , ) = foo.verProductos();
        Assert.equal(_ids[0], 1, "_ids[0] should be equal to 1");
    }

    function testProductDelivery() public {
        foo.agregarNuevoProducto("Product 2", 8);
        foo.entregarProducto(2);
        (
            uint256[] memory _ids,
            ,
            uint256[] memory _counts,
            uint256[] memory _countsDelivered
        ) = foo.verProductos();

        Assert.equal(uint256(_ids[1]), 2, "_ids[1] should be equal to 2");
        // console.log(_ids[1]);
        Assert.equal(_counts[1], 8, "_counts[1] should be equal to 8");
        // console.log(_counts[1]);
        Assert.equal(_countsDelivered[1], 8, "_counts[1] should be equal to 8");
        // console.log(_countsDelivered[1]);
    }

    function testExistingProductQuantity() public {
        foo.agregarNuevoProducto("Product 3", 22);

        // try foo.entregarProducto(3) {
        //     console.log("cantidades entregadas");
        // } catch Error(string memory reason) {
        //     console.log(reason);
        //     Assert.ok(false, string(abi.encodePacked("Entregando producto: -> ", reason)));
        // }

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
            uint256[] memory _countsDelivered
        ) = foo.verProductos();
        Assert.equal(_ids[2], 3, "_ids[2] should be equal to 1");
        console.log(_ids[2]);
        Assert.equal(33, _counts[2], "_counts[2] should be equal to 33");
        console.log(_counts[2]);
        Assert.equal(
            uint256(_countsDelivered[2]),
            uint256(33),
            "_countsDelivered[2] should be equal to 33"
        );
        console.log(_countsDelivered[2]);

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
