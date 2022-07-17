codeunit 58101 AutoRefreshDelay
{
    trigger OnRun()
    begin
        // Nothing to do, triggers update the factbox.
        // Remark: This sleep is taking one of the available child session concurrency slot for doing nothing.
        //         Be careful to not trigger too many of theses, otherwise you may exceed max concurency limits and tasks may be queued,
        //         degrading the end user experience.
        Sleep(20000);
    end;
}