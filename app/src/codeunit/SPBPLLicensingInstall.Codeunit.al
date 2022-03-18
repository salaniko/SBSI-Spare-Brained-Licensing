codeunit 71037 "SPBPL Licensing Install"
{
    Subtype = Install;

    trigger OnInstallAppPerDatabase()
    var
        SPBPLExtensionLicense: Record "SPBPL Extension License";
        SPBPLLicenseUtilities: Codeunit "SPBPL License Utilities";
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        // We install / update the 'Test' entry
        if not SPBPLExtensionLicense.Get(AppInfo.Id) then begin
            SPBPLExtensionLicense.Init();
            Evaluate(SPBPLExtensionLicense."Entry Id", AppInfo.Id);
            SPBPLExtensionLicense.Insert();
        end;
        SPBPLExtensionLicense."Extension Name" := AppInfo.Name + ' Test Subcription';
        SPBPLExtensionLicense."Product Code" := CopyStr(SPBPLLicenseUtilities.GetTestProductId(), 1, MaxStrLen(SPBPLExtensionLicense."Product Code"));
        SPBPLExtensionLicense."Product URL" := 'https://sbsiconsulting.gumroad.com/l/SBILicensingTest';
        SPBPLExtensionLicense."Support URL" := 'support@sbsiconsulting.fr';
        SPBPLExtensionLicense."Billing Support Email" := 'support@sbsiconsulting.fr';
        SPBPLExtensionLicense.Modify();
    end;
}
