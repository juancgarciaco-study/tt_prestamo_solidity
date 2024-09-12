// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol";
import "hardhat/console.sol";

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
// import "remix_accounts.sol";

import "/contracts/prestamo_jk.sol";

// <import file to test>

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract prestamo_1350_9_15_test {
    PrestamoJK foo;

    function beforeAll() public {
        uint256 _loanAmount = 1350;
        uint256 _interestRateYear = 9;
        uint256 _loanTerm = 15;

        // <instantiate contract>
        foo = new PrestamoJK(_loanAmount, _interestRateYear, _loanTerm);

        Assert.equal(
            foo.viewLoanAmount(),
            _loanAmount,
            "foo.viewLoanAmount should be equal to _loanAmount"
        );
    }

    function viewInterests() public {
        //Assert.equal(uint(1), uint(1), "1 should be equal to 1");
        uint256 int_year = foo.viewYearlyInterest();
        string memory int_year_f = foo.viewYearlyInterestFormat();
        //console.log("YearlyInterest", int_year);
        //console.log("YearlyInterestFormat", int_year_f);

        uint256 int_month = foo.viewMonthlyInterest();
        string memory int_month_f = foo.viewMonthlyInterestFormat();
        //console.log("MonthlyInterest", int_month);
        //console.log("MonthlyInterestFormat", int_month_f);

        /**** ------ ***/
        uint256 int_total = foo.viewTotalInterest();
        string memory int_total_f = foo.viewTotalInterestFormat();
        //console.log("TotalInterest", int_total);
        //console.log("TotalInterestFormat", int_total_f);

        // Asserts
        Assert.equal(
            int_year,
            12150000,
            "int_year should be equal to 12150000"
        );
        Assert.equal(
            int_year_f,
            "121.50000",
            "int_year_f should be equal to 121.50000"
        );
        // Asserts
        Assert.equal(
            int_month,
            1012500,
            "int_month should be equal to 1012500"
        );
        Assert.equal(
            int_month_f,
            "10.12500",
            "int_month_f should be equal to 10.12500"
        );
        // Asserts
        Assert.equal(
            int_total,
            15187500,
            "int_total should be equal to 15187500"
        );
        Assert.equal(
            int_total_f,
            "151.87500",
            "int_total_f should be equal to 151.87500"
        );
    }

    function viewPaymentsBase() public {
        uint256 pay_year = foo.viewYearlyPaymentBase();
        string memory pay_year_f = foo.viewYearlyPaymentBaseFormat();
        //console.log("YearlyPayment", pay_year);
        //console.log("YearlyPaymentFormat", pay_year_f);

        uint256 pay_month = foo.viewMonthlyPaymentBase();
        string memory pay_month_f = foo.viewMonthlyPaymentBaseFormat();
        //console.log("MonthlyPayment", pay_month);
        //console.log("MonthlyPaymentFormat", pay_month_f);

        uint256 pay_total = foo.viewTotalPaymentBase();
        string memory pay_total_f = foo.viewTotalPaymentBaseFormat();
        //console.log("totalPayment", int_total);
        //console.log("totalPaymentFormat", pay_total_f);

        // Asserts
        Assert.equal(
            pay_year,
            108000000,
            "pay_year should be equal to 108000000"
        );
        Assert.equal(
            pay_year_f,
            "1080.0",
            "pay_year_f should be equal to 1080.0"
        );
        // Asserts
        Assert.equal(
            pay_month,
            9000000,
            "pay_month should be equal to 9000000"
        );
        Assert.equal(
            pay_month_f,
            "90.0",
            "pay_month_f should be equal to 90.0"
        );
        // Asserts
        Assert.equal(
            pay_total,
            135000000,
            "pay_total should be equal to 135000000"
        );
        Assert.equal(
            pay_total_f,
            "1350.0",
            "pay_total_f should be equal to 1350.0"
        );
    }

    function viewPaymentsFinal() public {
        uint256 pay_year = foo.viewYearlyPaymentFinal();
        string memory pay_year_f = foo.viewYearlyPaymentFinalFormat();

        uint256 pay_month = foo.viewMonthlyPaymentFinal();
        string memory pay_month_f = foo.viewMonthlyPaymentFinalFormat();

        uint256 pay_total = foo.viewTotalPaymentFinal();
        string memory pay_total_f = foo.viewTotalPaymentFinalFormat();

        // Asserts
        Assert.equal(
            pay_year,
            120150000,
            "pay_year should be equal to 120150000"
        );
        Assert.equal(
            pay_year_f,
            "1201.50000",
            "pay_year_f should be equal to 1201.50000"
        );
        // Asserts
        Assert.equal(
            pay_month,
            10012500,
            "pay_month should be equal to 10012500"
        );
        Assert.equal(
            pay_month_f,
            "100.12500",
            "pay_month_f should be equal to 100.12500"
        );
        // Asserts
        Assert.equal(
            pay_total,
            150187500,
            "pay_total should be equal to 150187500"
        );
        Assert.equal(
            pay_total_f,
            "1501.87500",
            "pay_total_f should be equal to 1501.87500"
        );
    }
}
