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
contract prestamo_1111_14_5_test {
    PrestamoJK foo;

    function beforeAll() public {
        uint256 _loanAmount = 1111;
        uint256 _interestRateYear = 14;
        uint256 _loanTerm = 5;

        // <instantiate contract>
        foo = new PrestamoJK(_loanAmount, _interestRateYear, _loanTerm);


        Assert.equal(
            foo.viewLoanAmount(),
            _loanAmount,
            "foo.viewLoanAmount should be equal to _loanAmount"
        );
    }

    function viewInterests() public {
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
            15554000,
            "int_year should be equal to 15554000"
        );
        Assert.equal(
            int_year_f,
            "155.54000",
            "int_year_f should be equal to 155.54000"
        );
        // Asserts
        Assert.equal(
            int_month,
            1296166,
            "int_month should be equal to 1296166"
        );
        Assert.equal(
            int_month_f,
            "12.96166",
            "int_month_f should be equal to 12.96166"
        );
        // Asserts
        Assert.equal(
            int_total,
            6480830,
            "int_total should be equal to 6480830"
        );
        Assert.equal(
            int_total_f,
            "64.80830",
            "int_total_f should be equal to 64.80830"
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
            266640000,
            "pay_year should be equal to 266640000"
        );
        Assert.equal(
            pay_year_f,
            "2666.40000",
            "pay_year_f should be equal to 2666.40000"
        );
        // Asserts
        Assert.equal(
            pay_month,
            22220000,
            "pay_month should be equal to 22220000"
        );
        Assert.equal(
            pay_month_f,
            "222.20000",
            "pay_month_f should be equal to 222.20000"
        );
        // Asserts
        Assert.equal(
            pay_total,
            111100000,
            "pay_total should be equal to 111100000"
        );
        Assert.equal(
            pay_total_f,
            "1111.0",
            "pay_total_f should be equal to 1111.0"
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
            282194000,
            "pay_year should be equal to 282194000"
        );
        Assert.equal(
            pay_year_f,
            "2821.94000",
            "pay_year_f should be equal to 2821.94000"
        );
        // Asserts
        Assert.equal(
            pay_month,
            23516166,
            "pay_month should be equal to 23516166"
        );
        Assert.equal(
            pay_month_f,
            "235.16166",
            "pay_month_f should be equal to 235.16166"
        );
        // Asserts
        Assert.equal(
            pay_total,
            117580830,
            "pay_total should be equal to 1175.80830"
        );
        Assert.equal(
            pay_total_f,
            "1175.80830",
            "pay_total_f should be equal to 1175.80830"
        );
    }
}
