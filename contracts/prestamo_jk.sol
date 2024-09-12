// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract PrestamoJK {
    // Direccion del prestamista (quien despliega el contrato)
    address private borrower;
    // Monto del prestamo en criptomonedas
    uint256 private loanAmount;
    // Tasa de interes del prestamo (porcentaje anual)
    uint256 private interestRateYear;
    // Plazo del prestamo en meses
    uint256 private loanTerm;

    uint256 private yearlyInterest;
    uint256 private monthlyInterest;
    uint256 private totalInterest;

    uint256 private yearlyPaymentBase;
    uint256 private monthlyPaymentBase;
    uint256 private totalPaymentBase;

    uint256 private _multHigh = 1e5;
    //uint256 private _multLow = 1e4;
    uint256 private _pj = 100;
    uint256 private _monthsInYear = 12;

    constructor(
        uint256 _amount,
        uint256 _interestRateYear,
        uint256 _term
    ) {
        borrower = msg.sender;

        loanAmount = _amount;
        interestRateYear = _interestRateYear;
        loanTerm = _term;
        /*
        console.log("ctor --------------------->");
        console.log("ctor-loanAmount", loanAmount);
        console.log("ctor-interestRateYear", interestRateYear);
        console.log("ctor-loanTerm", loanTerm);
        console.log("ctor --------------------->");
        */
        calculateRates();
    }

    function calculateRates() private {
        calculateInterest();
        calculatePaymentBase();
    }

    function calculateInterest() private {
        uint256 _yearInterest = (loanAmount * interestRateYear) *
            (_multHigh / _pj);
        //console.log("_yearInterest", _yearInterest);
        uint256 _monthlyInterest = _yearInterest / _monthsInYear;
        //console.log("_monthlyInterest", _monthlyInterest);
        uint256 _totalInterest = _monthlyInterest * loanTerm;
        //console.log("_totalInterest", _totalInterest);

        // set public variables
        yearlyInterest = _yearInterest;
        monthlyInterest = _monthlyInterest;
        totalInterest = _totalInterest;
    }

    function calculatePaymentBase() private {
        /// Calculate base payments
        //pagoMensualTotal = ((loanAmount * 1000 + interesTotal) / plazo);
        //uint256 var3 = loanAmount * _multHigh + yearlyInterest;
        //monthlyPaymentBase = var3 / loanTerm;
        uint256 _yearPaymentBase = (loanAmount * (_monthsInYear * _multHigh)) /
            loanTerm;
        //console.log("_yearPaymentBase", _yearPaymentBase);
        //uint256 _monthlyPaymentBase = (loanAmount * _multLow) / loanTerm; //((loanAmount * _multLow) / (loanTerm / _monthsInYear));
        uint256 _monthlyPaymentBase = _yearPaymentBase / _monthsInYear;
        //console.log("_monthlyPaymentBase", _monthlyPaymentBase);
        uint256 _totalPaymentBase = _monthlyPaymentBase * loanTerm;
        //console.log("_totalPaymentBase", _totalPaymentBase);

        // set public variables
        yearlyPaymentBase = _yearPaymentBase;
        monthlyPaymentBase = _monthlyPaymentBase;
        totalPaymentBase = _totalPaymentBase;
    }

    function viewLoanAmount() public view returns (uint256) {
        return loanAmount;
    }

    //#region Interest methods
    function viewYearlyInterest() public view returns (uint256) {
        return yearlyInterest;
    }

    function viewYearlyInterestFormat() public view returns (string memory) {
        return
            showAsFraction(
                yearlyInterest / _multHigh,
                yearlyInterest % _multHigh
            );
    }

    function viewMonthlyInterest() public view returns (uint256) {
        return monthlyInterest;
    }

    function viewMonthlyInterestFormat() public view returns (string memory) {
        return
            showAsFraction(
                monthlyInterest / _multHigh,
                monthlyInterest % _multHigh
            );
    }

    function viewTotalInterest() public view returns (uint256) {
        return totalInterest;
    }

    function viewTotalInterestFormat() public view returns (string memory) {
        return
            showAsFraction(
                totalInterest / _multHigh,
                totalInterest % _multHigh
            );
    }

    //#endregion

    //#region paymentbase methods
    function viewYearlyPaymentBase() public view returns (uint256) {
        return yearlyPaymentBase;
    }

    function viewYearlyPaymentBaseFormat() public view returns (string memory) {
        return
            showAsFraction(
                yearlyPaymentBase / _multHigh,
                yearlyPaymentBase % _multHigh
            );
    }

    function viewMonthlyPaymentBase() public view returns (uint256) {
        return monthlyPaymentBase;
    }

    function viewMonthlyPaymentBaseFormat()
        public
        view
        returns (string memory)
    {
        return
            showAsFraction(
                monthlyPaymentBase / _multHigh,
                monthlyPaymentBase % _multHigh
            );
    }

    function viewTotalPaymentBase() public view returns (uint256) {
        return totalPaymentBase;
    }

    function viewTotalPaymentBaseFormat() public view returns (string memory) {
        return
            showAsFraction(
                totalPaymentBase / _multHigh,
                totalPaymentBase % _multHigh
            );
    }

    //#endregion

    //#region paymenttotal methods
    function viewYearlyPaymentFinal() public view returns (uint256) {
        return yearlyPaymentBase + yearlyInterest;
    }

    function viewYearlyPaymentFinalFormat()
        public
        view
        returns (string memory)
    {
        return
            showAsFraction(
                viewYearlyPaymentFinal() / _multHigh,
                viewYearlyPaymentFinal() % _multHigh
            );
    }

    function viewMonthlyPaymentFinal() public view returns (uint256) {
        return monthlyPaymentBase + monthlyInterest;
    }

    function viewMonthlyPaymentFinalFormat()
        public
        view
        returns (string memory)
    {
        return
            showAsFraction(
                viewMonthlyPaymentFinal() / _multHigh,
                viewMonthlyPaymentFinal() % _multHigh
            );
    }

    function viewTotalPaymentFinal() public view returns (uint256) {
        return totalPaymentBase + totalInterest;
    }

    function viewTotalPaymentFinalFormat() public view returns (string memory) {
        return
            showAsFraction(
                viewTotalPaymentFinal() / _multHigh,
                viewTotalPaymentFinal() % _multHigh
            );
    }

    //#endregion

    //#region utils methods
    function showAsFraction(uint256 IntegerPart, uint256 decimalPart)
        internal
        pure
        returns (string memory)
    {
        return
            string(
                abi.encodePacked(
                    uint2str(IntegerPart),
                    ".",
                    uint2str(decimalPart)
                )
            );
    }

    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            bstr[k] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }

    /* ----------------------------------- */
    function calculatePercentage(uint256 amount, uint256 bps)
        private
        pure
        returns (uint256)
    {
        require((amount * bps) >= 10_000);
        return (amount * bps) / 10_000;
    }

    function substring(
        string calldata str,
        uint256 start,
        uint256 end
    ) private pure returns (string memory) {
        return str[start:end];
    }
    //#endregion
}
