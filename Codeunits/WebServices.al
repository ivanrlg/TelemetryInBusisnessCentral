codeunit 58100 WebServices
{
    Permissions = tabledata TelemetryIoT = RIMD;
    trigger OnRun()
    begin
    end;

    procedure Ping(): Text
    begin
        exit('Pong');
    end;

    procedure InsertTelemetry(jsontext: Text): Text
    var
        TelemetryIoT: Record TelemetryIoT;
        JsonInput: JsonObject;
        JSONProperty: JsonObject;
        DeviceIdToken: JsonToken;
        HumidityToken: JsonToken;
        TemperatureToken: JsonToken;
        DateToken: JsonToken;
        BigText: Text;
        s: Page "Sales Order List";
    begin
        JsonInput.ReadFrom(jsontext);

        if not JsonInput.Get('DeviceId', DeviceIdToken) then begin
            Error('Error reading DeviceId');
        end;

        if not JsonInput.Get('Humidity', HumidityToken) then begin
            Error('Error reading Humidity');
        end;

        if not JsonInput.Get('Temperature', TemperatureToken) then begin
            Error('Error reading Temperature');
        end;

        if not JsonInput.Get('DateString', DateToken) then begin
            Error('Error reading Date');
        end;

        TelemetryIoT.Init();
        TelemetryIoT.DeviceId := DeviceIdToken.AsValue().AsCode();
        TelemetryIoT.LineNo := TelemetryIoT.GetLastLineNo(TelemetryIoT.DeviceId) + 1000;
        TelemetryIoT.Humidity := HumidityToken.AsValue().AsDecimal();
        TelemetryIoT.Temperature := TemperatureToken.AsValue().AsDecimal();
        TelemetryIoT.Date := DateToken.AsValue().AsText();
        if not TelemetryIoT.Insert() then begin
            JSONProperty.Add('IsSuccess', false);
            JSONProperty.Add('Message', 'The telemetry could not be inserted');
            JSONProperty.WriteTo(BigText);
            exit(BigText);
        end;

        JSONProperty.Add('IsSuccess', true);
        JSONProperty.Add('Message', 'The telemetry was inserted successfully.');
        JSONProperty.WriteTo(BigText);
        exit(BigText);
    end;
}