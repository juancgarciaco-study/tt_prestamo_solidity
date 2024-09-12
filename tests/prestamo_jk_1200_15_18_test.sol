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
contract prestamo_1200_15_18_test {
    PrestamoJK foo;

    function beforeAll() public {
        uint256 _loanAmount = 1200;
        uint256 _interestRateYear = 15;
        uint256 _loanTerm = 18;

        // <instantiate contract>
        foo = new PrestamoJK(_loanAmount, _interestRateYear, _loanTerm);

        /*
        console.log("test_beforeAll --------------------->");
        console.log("test-loanAmount", _loanAmount);
        console.log("test-interestRateYear", _interestRateYear);
        console.log("test-loanTerm", _loanTerm);
        console.log("test_beforeAll --------------------->");
        */
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
            18000000,
            "int_year should be equal to 18000000"
        );
        Assert.equal(
            int_year_f,
            "180.0",
            "int_year_f should be equal to 180.0"
        );
        // Asserts
        Assert.equal(int_month, 1500000, "int_month should be equal to 15");
        Assert.equal(
            int_month_f,
            "15.0",
            "int_month_f should be equal to 15.0"
        );
        // Asserts
        Assert.equal(
            int_total,
            27000000,
            "int_total should be equal to 27000000"
        );
        Assert.equal(
            int_total_f,
            "270.0",
            "int_total_f should be equal to 270.0"
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
            80000000,
            "pay_year should be equal to 80000000"
        );
        Assert.equal(
            pay_year_f,
            "800.0",
            "pay_year_f should be equal to 800.0"
        );
        // Asserts
        Assert.equal(
            pay_month,
            6666666,
            "pay_month should be equal to 6666666"
        );
        Assert.equal(
            pay_month_f,
            "66.66666",
            "pay_month_f should be equal to 66.66666"
        );
        // Asserts
        Assert.equal(
            pay_total,
            119999988,
            "pay_total should be equal to 119999988"
        );
        Assert.equal(
            pay_total_f,
            "1199.99988",
            "pay_total_f should be equal to 1199.99988"
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
            98000000,
            "pay_year should be equal to 98000000"
        );
        Assert.equal(
            pay_year_f,
            "980.0",
            "pay_year_f should be equal to 980.0"
        );
        // Asserts
        Assert.equal(
            pay_month,
            8166666,
            "pay_month should be equal to 8166666"
        );
        Assert.equal(
            pay_month_f,
            "81.66666",
            "pay_month_f should be equal to 81.66666"
        );
        // Asserts
        Assert.equal(
            pay_total,
            146999988,
            "pay_total should be equal to 146999988"
        );
        Assert.equal(
            pay_total_f,
            "1469.99988",
            "pay_total_f should be equal to 1469.99988"
        );
    }
}
