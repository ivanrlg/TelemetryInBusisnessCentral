page 58101 TelemetryCuePage
{
    PageType = CardPart;
    SourceTable = TelemetryIoT;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            field(DeviceID; Rec.DeviceID)
            {
                ApplicationArea = All;
                Caption = 'Device ID';
            }

            cuegroup(TelemetryCueContainer)
            {
                Caption = 'Telemetry';
                Visible = true;
                CuegroupLayout = Wide;
                field(AverageTemperatureCue; Rec."Average Temperature")
                {
                    Caption = 'Average Temperature';
                    ApplicationArea = All;
                }

                field(AverageHumidityCue; Rec."Average Humidity")
                {
                    Caption = 'Average Humidity';
                    ApplicationArea = All;
                }

                field(LastHumidityCue; LastHumidity)
                {
                    Caption = 'Last Humidity';
                    ApplicationArea = All;
                }
                field(LastTempertureCue; LastTemperture)
                {
                    Caption = 'Last Temperture';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        TelemetryIoT: Record TelemetryIoT;
    begin
        TelemetryIoT.SetRange(DeviceId, Rec.DeviceId);
        if TelemetryIoT.FindLast() then begin
            LastHumidity := TelemetryIoT.Humidity;
            LastTemperture := TelemetryIoT.Temperature;
        end;
    end;

    var
        LastTemperture: Decimal;
        LastHumidity: Decimal;
}