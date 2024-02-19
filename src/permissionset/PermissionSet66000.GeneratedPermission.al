permissionset 66000 GeneratedPermission
{
    Assignable = true;
    Permissions = report "CCS Sales Invoice" = X,
        report CustLedgerEntryReport = X,
        report "Delivery Note" = X,
        report "Item Stock Availability" = X,
        report ProformaInvoice = X,
        codeunit "CCS EventSubscriber" = X,
        page "CCS Purchase order Sub List" = X,
        page "CCS Sales order Sub List" = X;
}