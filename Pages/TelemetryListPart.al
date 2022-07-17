page 58102 "Telemetry List Part"
{
    PageType = ListPart;
    SourceTable = TelemetryIoT;
    Caption = 'Telemetry Values';
    RefreshOnActivate = true;
    SourceTableView = sorting(DeviceId, LineNo) order(ascending);
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(DeviceId; Rec.DeviceId)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Temperature; Rec.Temperature)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Humidity; Rec.Humidity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        ResetTempTable();
    end;

    procedure ResetTempTable()
    begin
        Rec.DeleteAll(false);
        CurrPage.Update(false);
    end;

    procedure UpdateSourceTable(NewRec: Record TelemetryIoT)
    var
        IdKey: Text;
        Value: Text;
        Modified: Boolean;
    begin
        repeat
            Rec.Init();
            Rec := NewRec;
            if not Rec.Insert() then
                Rec.Modify();

        until NewRec.Next() = 0;

        //CurrPage.Update(false);
    end;
}

