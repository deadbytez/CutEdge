@echo off
title CutEdge v1.11 - Microsoft Edge for Security and Privacy
color 1F

:MAINMENU
cls
echo / CutEdge v1.11                           \
echo / Microsoft Edge for Security and Privacy \
echo / Repo: github.com/azhcat/CutEdge         \
echo.
echo DESCRIPTION
echo ----------------------------------------------------------
echo This script fixes many common annoyances with Microsoft Edge
echo and makes the browser's user interface less cluttered.
echo It also applies security and privacy enhancements.
echo.
echo NOTE: These policies are up-to-date with Microsoft Edge version 137.
echo.
echo IMPORTANT NOTICE
echo ----------------------------------------------------------
echo 1. Without MDM FakeEnrollment, most Edge policy changes
echo    will NOT apply.
echo 2. As a side effect, Tamper Protection will be forcefully
echo    turned OFF on this device.
echo 3. You MUST restart Microsoft Edge after this script
echo    completes to activate the new policies.
echo 4. If websites do not work properly, enable third-party cookies
echo    for the website by clicking the padlock button next to the
echo    address bar, then go into the cookie files section where you
echo    can enable third-party cookies for that site.
echo.
echo MAIN MENU
echo ----------------------------------------------------------
echo [1] Run the script
echo [2] Exit
echo.
set /p mainchoice=Select an option [1-2]: 

if "%mainchoice%"=="1" goto APPLYALL
if "%mainchoice%"=="2" exit /b

echo.
echo Invalid choice. Please enter 1 or 2.
pause
goto MAINMENU

:APPLYALL
call :STEP1
goto MAINMENU

:STEP1
cls
echo STEP 1: Fake MDM Enrollment (to enable policy application)
echo ----------------------------------------------------------
echo This step will create registry entries to fake MDM enrollment.
echo.
echo Do you want to proceed?
echo   [Y]es - Apply MDM enrollment
echo   [N]o  - Skip
set /p mdmchoice=Your choice [Y/N]: 

if /i "%mdmchoice%"=="Y" (
    echo.
    echo Applying fake MDM enrollment...
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v EnrollmentState /t REG_DWORD /d 1 /f 
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v EnrollmentType /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v IsFederated /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v Flags /t REG_DWORD /d 14000063 /f
    reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v AcctUId /t REG_SZ /d "0x000000000000000000000000000000000000000000000000000000000000000000000000" /f
    reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v RoamingCount /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v SslClientCertReference /t REG_SZ /d "MY;User;0000000000000000000000000000000000000000" /f
    reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v ProtoVer /t REG_SZ /d "1.2" /f

    echo.
    echo Fake MDM enrollment applied!
    pause
    call :STEP2
    goto :eof
)
if /i "%mdmchoice%"=="N" (
    echo.
    echo Skipping MDM enrollment.
    pause
    call :STEP2
    goto :eof
)
echo.
echo Invalid choice. Please enter Y or N.
pause
goto STEP1


:STEP2
cls
echo STEP 2: Apply Microsoft Edge for Business Group Policies
echo ----------------------------------------------------------
echo Do you want to proceed and apply the Edge policies?
echo   [Y]es - Apply policies
echo   [N]o  - Skip
set /p polchoice=Your choice [Y/N]: 

if /i "%polchoice%"=="Y" (
    call :APPLYPOLICIES
    goto :eof
)
if /i "%polchoice%"=="N" (
    echo.
    echo Skipping Edge policies.
    pause
    goto :STEP3
)
echo.
echo Invalid choice. Please enter Y or N.
pause
goto STEP2

:APPLYPOLICIES
echo.
echo Applying Microsoft Edge group policy registry entries...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultJavaScriptJitSetting /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultSearchProviderEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultSearchProviderName /t REG_SZ /d "DuckDuckGo" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultSearchProviderSearchURL /t REG_SZ /d "https://duckduckgo.com/?q={searchTerms}" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v GenAILocalFoundationalModelSettings /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PasswordManagerEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EfficiencyModeEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PerformanceDetectorEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HomepageIsNewTabPage /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageAppLauncherEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageBingChatEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageCompanyLogoEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageContentEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageHideDefaultTopSites /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageLocation /t REG_SZ /d "about:blank" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPagePrerenderEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v NewTabPageQuickLinksEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v RestoreOnStartup /t REG_DWORD /d 5 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AADWebSiteSSOUsingThisProfileEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AIGenThemesEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AccessibilityImageLabelsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AddressBarTrendingSuggestEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AddressBarWorkSearchResultsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AdsSettingForIntrusiveAdsSites /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AdsTransparencyEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AutofillAddressEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AutofillCreditCardEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v AutofillMembershipsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BingAdsSuppression /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BrowserSignin /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ConfigureDoNotTrack /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ConfigureOnlineTextToSpeech /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ConfigureShare /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultBrowserSettingEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v CopilotPageContext /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DiagnosticData /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v DefaultShareAdditionalOSRegionSetting /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v Edge3PSerpTelemetryEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeAssetDeliveryServiceEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeAutofillMlEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeCollectionsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeEDropEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeEntraCopilotPageContext /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeOpenInSidebarEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeShoppingAssistantEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeWalletCheckoutEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EdgeWalletEtreeEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v EnhanceSecurityMode /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ForceBingSafeSearch /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ForceGoogleSafeSearch /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HttpsUpgradesEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HideFirstRunExperience /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HideInternetExplorerRedirectUXForIncompatibleSitesEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v InAppSupportEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v LiveCaptionsAllowed /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v LocalBrowserDataShareEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v LocalProvidersEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v MSAWebSiteSSOUsingThisProfileAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v MediaRouterCastAllowAllIPs /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v MicrosoftEdgeInsiderPromotionEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PersonalizationReportingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PersonalizeTopSitesInCustomizeSidebarEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PinningWizardAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v PromptForDownloadLocation /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ReadAloudEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SavingBrowserHistoryDisabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SearchInSidebarEnabled /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SearchSuggestEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SearchbarAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SearchbarIsEnabledOnStartup /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SendIntranetToInternetExplorer /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ShowMicrosoftRewards /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v ShowRecommendationsEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SpeechRecognitionEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SpellcheckEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SplitScreenEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SyncDisabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v TrackingPrevention /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v TaskManagerEndProcessEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v TranslateEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v UrlDiagnosticDataEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v UserFeedbackAllowed /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v WalletDonationEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HubsSidebarEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v TabServicesEnabled /t REG_DWORD /d 0 /f
echo.
echo Do you want to block third-party cookies?
echo This may cause issues with most websites but
echo greatly improves privacy.
echo   [Y]es - Block third-party cookies
echo   [N]o  - Skip

:THIRDPARTY
set /p thirdpartychoice=Your choice [Y/N]: 
if /i "%thirdpartychoice%"=="Y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BlockThirdPartyCookies /t REG_DWORD /d 1 /f
    echo.
    goto :BROWSERHISTORY
)
if /i "%thirdpartychoice%"=="N" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BlockThirdPartyCookies /t REG_DWORD /d 0 /f
    echo.
    goto :BROWSERHISTORY
)
echo Invalid choice.
pause
goto :THIRDPARTY

:BROWSERHISTORY
echo Do you want to disable saving browser history?
echo   [Y]es - Disable saving browser history
echo   [N]o  - Skip
set /p historychoice=Your choice [Y/N]: 
if /i "%historychoice%"=="Y" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SavingBrowserHistoryDisabled /t REG_DWORD /d 1 /f
    echo.
    goto :POLICIESDONE
)
if /i "%historychoice%"=="N" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v SavingBrowserHistoryDisabled /t REG_DWORD /d 0 /f
    echo.
    goto :POLICIESDONE
)
echo Invalid choice.
pause
goto :BROWSERHISTORY

:POLICIESDONE
echo Edge policies applied!
pause
goto :STEP3


:STEP3
cls
echo STEP 3: Download and Apply Pre-Configured Edge Profile
echo ----------------------------------------------------------
echo Would you like to download and apply an already configured Edge profile?
echo Read the project's GitHub page for more info on what it does.
echo Remember to set your own preferred language in the settings afterwards.
echo.
echo IMPORTANT: Update Edge at least to version 137 before applying!
echo   [Y]es - Download and apply the profile
echo   [N]o  - Skip this step
set /p profilechoice=Your choice [Y/N]:

if /i "%profilechoice%"=="Y" (
    echo.
    echo Downloading and applying Edge profile...
    powershell -NoProfile -Command ^
        "$user = [Environment]::GetFolderPath('UserProfile');" ^
        "$downloads = Join-Path $user 'Downloads';" ^
        "$url = 'https://github.com/deadbytez/CutEdge/raw/refs/heads/main/edge-profile.zip';" ^
        "$zip = Join-Path $downloads 'edge-profile.zip';" ^
        "Invoke-WebRequest -Uri $url -OutFile $zip;" ^
        "Get-Process msedge -ErrorAction SilentlyContinue | Stop-Process -Force;" ^
        "$edgePath = Join-Path $env:LOCALAPPDATA 'Microsoft\Edge';" ^
        "if (Test-Path $edgePath) { Rename-Item -Path $edgePath -NewName 'Edge-Backup' -Force; }" ^
        "Expand-Archive -Path $zip -DestinationPath (Join-Path $env:LOCALAPPDATA 'Microsoft') -Force;"
    echo.
    echo Edge profile applied successfully!
    pause
) else (
    echo.
    echo Skipping Edge profile step.
    pause
)
goto MAINMENU