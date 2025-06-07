@echo off
title CutEdge v1.0 - Microsoft Edge for Security and Privacy

color 1F

REM Centered title (80 characters wide)
echo.
echo                               ===========================
echo                      CutEdge v1.0 - Microsoft Edge for Security and Privacy
echo                               ===========================
echo.

echo  DESCRIPTION
echo ----------------------------------------------------------
echo This script fixes many common annoyances with Microsoft Edge
echo and makes the browser's user interface less cluttered.
echo It also applies security and privacy enhancements.
echo.
echo NOTE: These policies are up-to-date with Microsoft Edge version 137.
echo.
echo  IMPORTANT NOTICE
echo ----------------------------------------------------------
echo 1. Without MDM FakeEnrollment, most Edge policy changes
echo    will NOT apply.
echo 2. As a side effect, Tamper Protection will be forcefully
echo    turned OFF on this device.
echo 3. You MUST restart Microsoft Edge after this script
echo    completes to activate the new policies.
echo.
echo 4. If websites do not work properly, enable third-party cookies
echo    for the website by clicking the padlock button next to the
echo    address bar, then go into the cookie files section where you
echo    can enable third-party cookies for that site.
echo ----------------------------------------------------------
echo.

:MAINMENU
echo MAIN MENU
echo ----------------------------------------------------------
echo [1] Apply all changes (Step 1 and Step 2)
echo [2] Revert all changes
echo [3] Revert only Step 1 (MDM-FakeEnrollment)
echo [4] Revert only Step 2 (Edge policies)
echo [5] Exit
echo.
set /p mainchoice=Select an option [1-5]: 

if "%mainchoice%"=="1" goto APPLYALL
if "%mainchoice%"=="2" goto REVERTALL
if "%mainchoice%"=="3" goto REVERTMDM
if "%mainchoice%"=="4" goto REVERTPOLICIES
if "%mainchoice%"=="5" exit /b

echo.
echo Invalid choice. Please enter 1, 2, 3, 4, or 5.
goto MAINMENU

:APPLYALL
call :STEP1
call :STEP2
goto END

:STEP1
:MDMSTEP
echo STEP 1: Enroll this device with Fake MDM (MDM-FakeEnrollment)
echo ----------------------------------------------------------
echo This step is required to make Windows "feel" MDM-managed.
echo.
echo Do you want to enroll this device with MDM-FakeEnrollment?
echo   [Y]es - Enroll now
echo   [N]o  - Skip
echo   [AE]   - Already Enrolled (skip to next step)
set /p enrollchoice=Your choice [Y/N/AE]: 

if /i "%enrollchoice%"=="Y" (
    goto ENROLL
) else if /i "%enrollchoice%"=="AE" (
    echo.
    echo Skipping MDM enrollment (already enrolled).
    goto ENDSTEP1
) else if /i "%enrollchoice%"=="N" (
    echo.
    echo Skipping MDM enrollment.
    goto ENDSTEP1
) else (
    echo.
    echo Invalid choice. Please enter Y, N, or AE.
    goto MDMSTEP
)

:ENROLL
echo.
echo Applying Fake MDM Enrollment registry entries...
reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v EnrollmentState /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v EnrollmentType /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v IsFederated /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v Flags /t REG_DWORD /d 14000063 /f
reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v AcctUId /t REG_SZ /d "0x000000000000000000000000000000000000000000000000000000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v RoamingCount /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v SslClientCertReference /t REG_SZ /d "MY;User;0000000000000000000000000000000000000000" /f
reg add "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /v ProtoVer /t REG_SZ /d "1.2" /f
echo.
echo Fake MDM Enrollment complete!
echo.
:ENDSTEP1
exit /b

:STEP2
:POLICYSTEP
echo STEP 2: Apply Microsoft Edge for Business Group Policies
echo ----------------------------------------------------------
echo Do you want to proceed and apply the Edge policies?
echo   [Y]es - Apply policies
echo   [N]o  - Skip
set /p polchoice=Your choice [Y/N]: 

if /i "%polchoice%"=="Y" (
    goto APPLYPOLICIES
) else if /i "%polchoice%"=="N" (
    echo.
    echo Skipping Edge policies.
    exit /b
) else (
    echo.
    echo Invalid choice. Please enter Y or N.
    goto POLICYSTEP
)

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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BlockThirdPartyCookies /t REG_DWORD /d 1 /f
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
echo Edge policies applied!
exit /b

:REVERTALL
call :REVERTMDM
call :REVERTPOLICIES
goto END

:REVERTMDM
echo.
echo Reverting Step 1: Removing MDM-FakeEnrollment...
reg delete "HKLM\SOFTWARE\Microsoft\Enrollments\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts\FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF" /f >nul 2>&1
echo MDM-FakeEnrollment removed.
exit /b

:REVERTPOLICIES
echo.
echo Reverting Step 2: Removing Edge policies...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /f >nul 2>&1
echo Edge policies removed.
exit /b

:END
echo.
echo ==========================================================
echo   Operation complete. If you applied or reverted policies,
echo   please restart Microsoft Edge for changes to take effect.
echo ==========================================================
echo.
pause
exit /b
