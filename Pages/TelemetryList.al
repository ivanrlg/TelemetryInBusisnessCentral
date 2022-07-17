page 58100 "Telemetry List"
{
    PageType = List;
    SourceTable = TelemetryIoT;
    Caption = 'Telemetry List';
    RefreshOnActivate = true;
    SourceTableView = sorting(DeviceId, LineNo) order(ascending);
    ApplicationArea = all;
    UsageCategory = Lists;

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
}
