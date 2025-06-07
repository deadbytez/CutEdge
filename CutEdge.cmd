@echo off
title CutEdge v1.0 - Microsoft Edge for Security and Privacy
color 1F

:MAINMENU
cls
echo ==========================================================
echo                   CutEdge v1.0
echo      Microsoft Edge for Security and Privacy
echo ==========================================================
echo.
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
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\00000000-0000-0000-0000-000000000000" /v "EnrollmentType" /t REG_DWORD /d 6 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\00000000-0000-0000-0000-000000000000" /v "EnrollmentID" /t REG_SZ /d "00000000-0000-0000-0000-000000000000" /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\00000000-0000-0000-0000-000000000000" /v "DeviceCertificate" /t REG_BINARY /d 00 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Enrollments\00000000-0000-0000-0000-000000000000" /v "UPN" /t REG_SZ /d "user@domain.com" /f >nul
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
    goto :eof
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
pause
goto :eof

:REVERTALL
call :REVERTMDM
call :REVERTPOLICIES
goto MAINMENU

:REVERTMDM
cls
echo REVERT: Fake MDM Enrollment
echo ----------------------------------------------------------
echo This will remove the fake MDM enrollment registry keys.
echo.
reg delete "HKLM\SOFTWARE\Microsoft\Enrollments\00000000-0000-0000-0000-000000000000" /f >nul 2>&1
echo Fake MDM enrollment removed (if it existed).
pause
goto :eof

:REVERTPOLICIES
cls
echo REVERT: Microsoft Edge Policies
echo ----------------------------------------------------------
echo This will remove the Edge group policy registry keys.
echo.
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Edge" /f >nul 2>&1
echo Edge policies removed (if they existed).
pause
goto :eof
