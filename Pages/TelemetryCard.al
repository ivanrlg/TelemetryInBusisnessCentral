page 58103 TelemetryIoTCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TelemetryIoT;
    Caption = 'Telemetry Card';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            part(TelemetryValues; "Telemetry List Part")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Telemetry History';
            }
            group(PowerBI)
            {
                part("BI Temperature Control"; "Power BI Report FactBox")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Temperature Control';
                }
                part("BI Humidity Control"; "Power BI Report FactBox")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Humidity Control';
                }
            }
        }

        area(factboxes)
        {

            part(TelemetryCuePage; TelemetryCuePage)
            {
                Caption = 'Telemetry Cue';
                ApplicationArea = All;
                SubPageLink = DeviceId = FIELD(DeviceId);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.TelemetryValues.Page.UpdateSourceTable(Rec);
        CurrPage.EnqueueBackgroundTask(PbtTaskId, Codeunit::AutoRefreshDelay);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        if (TaskId = PbtTaskId) then begin

            Rec.FindSet();
            CurrPage.TelemetryValues.Page.UpdateSourceTable(Rec);

            CurrPage.TelemetryValues.Page.Update(false);

            CurrPage.EnqueueBackgroundTask(PbtTaskId, Codeunit::AutoRefreshDelay);
        end;
    end;

    trigger OnOpenPage()
    begin
        CurrPage."BI Temperature Control".PAGE.InitFactBox('Temperature Control', CurrPage.Caption, PowerBIVisible);
        CurrPage."BI Humidity Control".PAGE.InitFactBox('Humidity Control', CurrPage.Caption, PowerBIVisible);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PowerBIVisible := true;

        CurrPage."BI Temperature Control".PAGE.SetCurrentListSelection(Format(Rec.LineNo), false, PowerBIVisible);
        CurrPage."BI Humidity Control".PAGE.SetCurrentListSelection(Format(Rec.LineNo), false, PowerBIVisible);
    end;

    var
        PowerBIVisible: Boolean;
        PbtTaskId: Integer;
        AutoRefreshValue: Text;
}

