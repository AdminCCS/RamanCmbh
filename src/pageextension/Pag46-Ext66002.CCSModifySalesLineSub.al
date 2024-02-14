/// <summary>
/// PageExtension CCS ModifySalesLineSub (ID 66002) extends Record Sales Order Subform //46.
/// </summary>
pageextension 66002 "CCS ModifySalesLineSub" extends "Sales Order Subform" //46
{
    layout
    {
        addbefore(Quantity)
        {
            field("Order Type"; rec."CCS Order Type")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    if rec."CCS Order Type" IN [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
                        editPO := false;
                        editSO := false;
                    end;
                    if rec."CCS Order Type" IN [rec."CCS Order Type"::"Instant Order"] then begin
                        editPO := false;
                        editSO := true;
                    end;
                    if rec."CCS Order Type" IN [rec."CCS Order Type"::"Disposition order"] then begin
                        editSO := false;
                        editPO := true;
                    end;
                end;
            }
        }
        addbefore(Quantity)
        {
            field("CCS BA Number"; Rec."CCS BA Number")
            {
                ApplicationArea = all;
                Editable = editSO;
            }
            field("CCS PO Number"; Rec."CCS PO Number")
            {
                ApplicationArea = all;
                Editable = editPO;
            }
        }
        addafter(Quantity)
        {

            field("Unit Cost"; rec."Unit Cost")
            {
                ApplicationArea = all;
                Editable = False;
            }

            field("CCS Masterbox Qty"; rec."CCS Masterbox Qty")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field
            ("CCS Cartons"; rec."CCS Cartons")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("CCS Rebate 1 %"; rec."CCS Rebate 1 %")
            {
                ApplicationArea = all;
            }
            field("CCS Rebate 2 %"; rec."CCS Rebate 2 %")
            {
                ApplicationArea = all;
            }

        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
            Editable = true;
        }
    }
    trigger OnOpenPage()
    begin
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
            editPO := false;
            editSO := false;
        end;
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Instant Order"] then begin
            editPO := false;
            editSO := true;
        end;
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Disposition order"] then begin
            editSO := false;
            editPO := true;
        end;
    end;

    trigger OnAfterGetRecord()

    begin
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
            editPO := false;
            editSO := false;
        end;
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Instant Order"] then begin
            editPO := false;
            editSO := true;
        end;
        if rec."CCS Order Type" IN [rec."CCS Order Type"::"Disposition order"] then begin
            editSO := false;
            editPO := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin

        // SalesLine.Reset();
        // SalesLine.SetRange("Document No.", Rec."CCS BA Number");
        // SalesLine.SetRange("No.", Rec."No.");
        // if SalesLine.FindFirst() then
        //     error('Can not delete this line,this order tagged on order no%1', SalesLine."Document No.");

    end;

    var
        editPO: Boolean;
        editSO: Boolean;
}
