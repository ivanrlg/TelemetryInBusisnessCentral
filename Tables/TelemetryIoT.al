table 58100 TelemetryIoT
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; DeviceId; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Humidity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Temperature; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Date; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Average Temperature"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Average("TelemetryIoT".Temperature WHERE(DeviceId = Field(DeviceID)));
        }
        field(7; "Average Humidity"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Average("TelemetryIoT".Humidity WHERE(DeviceId = Field(DeviceID)));
        }
    }

    keys
    {
        key(Key1; DeviceId, LineNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetLastLineNo(DeviceId: Code[50]): Integer
    var
        Devices: Record TelemetryIoT;
    begin
        Devices.SetRange(DeviceId, DeviceId);
        if Devices.FindLast() then begin
            exit(Devices.LineNo)
        end else begin
            exit(1000);
        end;
    end;
}