# CutEdge
<img src="https://github.com/azhcat/CutEdge/blob/main/preview.png?raw=true" width="85%">
This script allows you to automatically fix annoyances with Microsoft Edge & make it more private and secure.

The default search engine is DuckDuckGo. As of now, you may set your own one by modifying the script or the registry values found in Step 2.

After applying the script it is recommended to go into Microsoft Edge settings and adjust your settings since not everything is available via a group policy.

## Supported Windows editions
Windows 10 Pro or greater

The Home edition was not tested by me. Feedback will be appreciated.

## Video preview (YouTube)
[![CutEdge Preview on YouTube](https://img.youtube.com/vi/6CmJUsoGjGM/0.jpg)](https://www.youtube.com/watch?v=6CmJUsoGjGM)

## Important notes
1. Without MDM FakeEnrollment, most Edge policy changes will NOT apply.
2. As a side effect, **Tamper Protection will be forcefully turned OFF** on this device.
3. You MUST restart Microsoft Edge after this script completes to activate the new policies.
4. If websites do not work properly, **enable third-party cookies for the website** by clicking the padlock button next to the address bar, then go into the cookie files section where you can enable third-party cookies for that site.
---
# How does this script work?

## Step 1: MDM-FakeEnrollment

Some Microsoft Edge policies (such as homepage, new tab, search provider, and others) are only honored on devices that are either domain-joined or enrolled in an MDM (Mobile Device Management) solution. On standalone or non-domain-joined Windows devices, these policies are ignored even if set in the registry unless the device appears to be MDM-managed.

**MDM-FakeEnrollment** is a workaround that adds a minimal set of registry keys to make Edge "think" the device is enrolled in MDM, allowing all restricted policies to be applied and enforced.

> **Note:** This method does not actually enroll your device in any real MDM service; it simply sets the required registry keys so Edge applies all policies as if it were managed.

**Credit:** This solution was discovered and documented by [Gunnar Haslinger at hitco.at](https://hitco.at/blog/apply-edge-policies-for-non-domain-joined-devices/).

### What does MDM-FakeEnrollment do?

- Sets a few registry keys under `HKLM\SOFTWARE\Microsoft\Enrollments` and `HKLM\SOFTWARE\Microsoft\Provisioning\OMADM\Accounts` to mimic the presence of an MDM provider.
- Unlocks the ability to apply and enforce all Microsoft Edge policies, even on non-domain-joined devices.
- **Side effect:** Windows Defender Tamper Protection will be **TURNED OFF**. You can use an alternative anti-virus (such as Malwarebytes or Kaspersky) to bypass this issue.

For more details and the original method, see [this blog post](https://hitco.at/blog/apply-edge-policies-for-non-domain-joined-devices/).

---

### Alternative for MDM-FakeEnrollment
You can attempt to join an Active Directory domain - Microsoft Edge should accept policies when your computer is in such a domain.

## Step 2: Microsoft Edge Policy Registry Settings

These policies are up-to-date with Microsoft Edge version 137.

Location: **HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge**
| Registry Value | Value Set | Description |
|---|---|---|
| DefaultJavaScriptJitSetting | 2 | Disables JavaScript JIT (Just-In-Time compilation) for all sites. Improves security but may reduce performance or break some sites. |
| DefaultSearchProviderEnabled | 1 | Enables the default search provider in the address bar. |
| DefaultSearchProviderName | "DuckDuckGo" | Sets the display name of the default search provider. |
| DefaultSearchProviderSearchURL | "https://duckduckgo.com/?q={searchTerms}" | Sets the search URL template for the default search provider. `{searchTerms}` is replaced by the user's query. |
| SavingBrowserHistoryDisabled | 1 (disabled) or 0 (enabled) | Disables saving browser history. User's choice. |
| GenAILocalFoundationalModelSettings | 1 | Disallows Edge to download and use local GenAI foundational models for AI features. |
| PasswordManagerEnabled | 0 | Disables Edge's built-in password manager and the offer to save passwords. |
| EfficiencyModeEnabled | 1 | Enables Efficiency Mode to reduce resource usage when the browser is inactive. |
| PerformanceDetectorEnabled | 0 | Disables the Performance Detector, which suggests actions to improve browsing performance. |
| StartupBoostEnabled | 0 | Disables Startup Boost, which preloads Edge processes in the background for faster startup. |
| HomepageIsNewTabPage | 1 | Sets the homepage to the New Tab page. |
| NewTabPageAppLauncherEnabled | 1 | Hides the app launcher on the New Tab page. |
| NewTabPageBingChatEnabled | 1 | Disables Bing Chat on the New Tab page. |
| NewTabPageCompanyLogoEnabled | 1 | Shows the company logo on the New Tab page (for managed devices). |
| NewTabPageContentEnabled | 0 | Disables content (like news and weather) on the New Tab page. |
| NewTabPageHideDefaultTopSites | 1 | Hides the default top sites on the New Tab page. |
| NewTabPageLocation | "about:blank" | Sets the URL loaded for the New Tab page. |
| NewTabPagePrerenderEnabled | 0 | Disables pre-rendering of the New Tab page. |
| NewTabPageQuickLinksEnabled | 0 | Disables quick links on the New Tab page. |
| RestoreOnStartup | 5 | Controls what Edge displays on startup (5 = New Tab). |
| AADWebSiteSSOUsingThisProfileEnabled | 0 | Disables Azure AD SSO for websites using the current profile. |
| AIGenThemesEnabled | 0 | Disables AI-generated themes in Edge. |
| AccessibilityImageLabelsEnabled | 0 | Disables automatic image labeling for accessibility. |
| AddressBarTrendingSuggestEnabled | 0 | Disables trending search suggestions in the address bar. |
| AddressBarWorkSearchResultsEnabled | 0 | Disables work search results in the address bar for enterprise users. |
| AdsSettingForIntrusiveAdsSites | 2 | Blocks ads on sites with intrusive ads. |
| AdsTransparencyEnabled | 0 | Disables ad transparency features. |
| AutofillAddressEnabled | 0 | Disables autofill for addresses. |
| AutofillCreditCardEnabled | 0 | Disables autofill for credit cards. |
| AutofillMembershipsEnabled | 0 | Disables autofill for membership cards and loyalty programs. |
| BackgroundModeEnabled | 0 | Disables running Edge in the background after closing all windows. |
| BingAdsSuppression | 1 | Enables Bing Ads suppression. |
| BlockThirdPartyCookies | 1 (enabled) or 0 (disabled) | Enables blocking of third-party cookies. User's choice. |
| BrowserSignin | 0 | Disables the ability to sign in to Edge with a Microsoft account. |
| ConfigureDoNotTrack | 0 | Disables sending "Do Not Track" requests. |
| ConfigureOnlineTextToSpeech | 0 | Disables online text-to-speech services. |
| ConfigureShare | 1 | Disables the Share feature in Edge. |
| DefaultBrowserSettingEnabled | 1 | Sets Edge as the default browser. |
| CopilotPageContext | 0 | Disables Copilot's access to page context for AI features. |
| DiagnosticData | 0 | Disables sending diagnostic data to Microsoft. |
| DefaultShareAdditionalOSRegionSetting | 2 | Controls sharing features based on OS region settings. |
| Edge3PSerpTelemetryEnabled | 0 | Disables telemetry for third-party search engine results pages. |
| EdgeAssetDeliveryServiceEnabled | 0 | Disables the Edge Asset Delivery Service. |
| EdgeAutofillMlEnabled | 0 | Disables machine learning-based autofill predictions. |
| EdgeCollectionsEnabled | 0 | Disables the Collections feature. |
| EdgeEDropEnabled | 0 | Disables the Edge Drop feature (file sharing). |
| EdgeEntraCopilotPageContext | 0 | Disables Entra Copilot's access to page context. |
| EdgeOpenInSidebarEnabled | 0 | Disables the "Open in sidebar" feature. |
| EdgeShoppingAssistantEnabled | 0 | Disables the Shopping Assistant feature. |
| EdgeWalletCheckoutEnabled | 0 | Disables the Edge Wallet checkout feature. |
| EdgeWalletEtreeEnabled | 0 | Disables the Edge Wallet Etree feature. |
| EnhanceSecurityMode | 2 | Sets Enhanced Security Mode (2 = Strict). |
| ForceBingSafeSearch | 0 | Does not force Bing SafeSearch. |
| ForceGoogleSafeSearch | 0 | Does not force Google SafeSearch. |
| HttpsUpgradesEnabled | 1 | Enables automatic upgrades from HTTP to HTTPS. |
| HideFirstRunExperience | 1 | Hides the first run experience for new users. |
| HideInternetExplorerRedirectUXForIncompatibleSitesEnabled | 1 | Hides the Internet Explorer redirect user experience for incompatible sites. |
| InAppSupportEnabled | 0 | Disables in-app support features. |
| LiveCaptionsAllowed | 1 | Enables live captions for media playback. |
| LocalBrowserDataShareEnabled | 0 | Disables sharing of local browser data. |
| LocalProvidersEnabled | 0 | Disables local search providers. |
| MSAWebSiteSSOUsingThisProfileAllowed | 0 | Blocks Microsoft Account SSO for websites using the current profile. |
| MediaRouterCastAllowAllIPs | 0 | Blocks casting to all IP addresses. |
| MicrosoftEdgeInsiderPromotionEnabled | 0 | Disables promotion of Edge Insider builds. |
| PersonalizationReportingEnabled | 0 | Disables personalization reporting. |
| PersonalizeTopSitesInCustomizeSidebarEnabled | 0 | Disables personalizing top sites in the sidebar. |
| PinningWizardAllowed | 0 | Disables the Pinning Wizard feature. |
| PromptForDownloadLocation | 0 | Disables prompt to choose a download location for each download. |
| ReadAloudEnabled | 1 | Enables the Read Aloud feature. |
| SavingBrowserHistoryDisabled | 1 | Disables saving of browsing history. |
| SearchInSidebarEnabled | 2 | Disables the "Search in sidebar" feature. |
| SearchSuggestEnabled | 0 | Disables search suggestions in the address bar. |
| SearchbarAllowed | 0 | Disables the Edge Search Bar feature. |
| SearchbarIsEnabledOnStartup | 0 | Disables the Edge Search Bar on startup. |
| SendIntranetToInternetExplorer | 0 | Does not send intranet sites to Internet Explorer mode. |
| ShowMicrosoftRewards | 0 | Hides Microsoft Rewards in Edge. |
| ShowRecommendationsEnabled | 0 | Hides recommendations in Edge. |
| SpeechRecognitionEnabled | 0 | Disables speech recognition features. |
| SpellcheckEnabled | 0 | Disables spellcheck. |
| SplitScreenEnabled | 1 | Enables the split screen feature. |
| SyncDisabled | 1 | Disables synchronization of Edge data across devices. |
| TrackingPrevention | 3 | Sets tracking prevention to Strict. |
| TaskManagerEndProcessEnabled | 1 | Enables the ability to end processes in the Edge task manager. |
| TranslateEnabled | 0 | Disables the built-in translation feature. |
| UrlDiagnosticDataEnabled | 0 | Disables sending URL diagnostic data to Microsoft. |
| UserFeedbackAllowed | 0 | Disables the ability to send feedback to Microsoft. |
| WalletDonationEnabled | 0 | Disables the Edge Wallet donation feature. |
| HubsSidebarEnabled | 0 | Disables the Hubs Sidebar feature. |
| TabServicesEnabled | 0 | Disables Tab Services (grouping, sharing, etc). |
| EnableMediaRouter | 0 | Disables the Media Router (casting) feature in Edge, preventing users from streaming content to other devices. |
| CACertificateManagementAllowed | 2 | Disallows users from managing CA certificates in Edge; users can only view certificates, not manage them. |
| CAPlatformIntegrationEnabled | 0 | Disables use of user-added TLS certificates from platform trust stores for server authentication in Edge. |
| AutomaticFullscreenBlockedForUrls | * | Blocks all sites from entering fullscreen automatically without user gesture, enhancing security against unwanted fullscreen requests. |
| CookiesBlockedForUrls | ntp.msn.com | Blocks cookies from being set or read by ntp.msn.com (I believe Microsoft Edge keeps contacting this domain). |
| DefaultGeolocationSetting | 2 | Disables location access for all sites by default, preventing websites from accessing geolocation data. |
| DefaultInsecureContentSetting | 2 | Blocks insecure content (HTTP) from loading on HTTPS pages by default, improving security. |
| DefaultCookiesSetting | 4 | Blocks all third-party cookies by default, maximizing privacy. |
| DefaultThirdPartyStoragePartitioningSetting | 1 | Enables third-party storage partitioning by default, isolating third-party storage for privacy. |
| DefaultFileSystemReadGuardSetting | 2 | Blocks sites from reading files via the File System API by default, increasing data security. |
| DefaultFileSystemWriteGuardSetting | 2 | Blocks sites from writing files via the File System API by default, increasing data security. |
| DefaultWebBluetoothGuardSetting | 2 | Blocks sites from accessing Bluetooth devices by default, enhancing device security. |
| DefaultWebHidGuardSetting | 2 | Blocks sites from accessing Human Interface Devices (HID) by default, improving security. |
| DefaultWindowManagementSetting | 2 | Blocks sites from managing windows (e.g., opening/closing) by default, reducing risk of abuse. |
| ShowPDFDefaultRecommendationsEnabled | 0 | Disables prompts to set Edge as the default PDF reader, reducing user interruptions. |
| SpotlightExperiencesAndRecommendationsEnabled | 0 | Disables personalized recommendations, tips, and notifications for Microsoft services in Edge. |
| FeatureFlagOverridesControl | 1 | Allows users to override feature flags in Edge, enabling advanced customization. |
| ExtensionInstallBlocklist | * | Blocks installation of all extensions in Edge, maximizing control and security. |
| ProactiveAuthWorkflowEnabled | 0 | Disables proactive authentication workflows in Edge, restricting automatic sign-in scenarios. |
| SeamlessWebToBrowserSignInEnabled | 0 | Disables seamless web-to-browser sign-in, requiring explicit user authentication. |
| WebToBrowserSignInEnabled | 0 | Disables web-to-browser sign-in, preventing automatic sign-in flows. |
| EdgeManagementEnabled | 0 | Disables Edge management features, restricting centralized browser management. |
| MAMEnabled | 0 | Disables Mobile Application Management (MAM) support in Edge. |
| NativeMessagingBlocklist | * | Blocks all native messaging hosts, preventing extensions from communicating with native applications. |
| PinBrowserEssentialsToolbarButton | 0 | Hides the Browser Essentials toolbar button in Edge. |
| InsecurePrivateNetworkRequestsAllowed | 0 | Disallows insecure private network requests, enhancing network security. |
| PrivateNetworkAccessRestrictionsEnabled | 0 | Disables private network access restrictions. |
| RelatedWebsiteSetsEnabled | 0 | Disables Related Website Sets, preventing Edge from grouping related sites for features like cookies and storage. |
| NewTabPageAllowedBackgroundTypes | 3 | Restricts the types of backgrounds allowed on the new tab page to those specified by value 3. |
| NewTabPageSearchBox | redirect | Configures the new tab page search box to redirect searches to the default search provider. |
| EdgeWorkspacesEnabled | 0 | Disables Edge Workspaces, preventing collaborative browsing sessions. |
| AdditionalSearchBoxEnabled | 0 | Disables the additional search box on the new tab page. |
| EditFavoritesEnabled | 0 | Disables the ability to edit favorites in Edge. |
| PaymentMethodQueryEnabled | 0 | Disables querying for payment methods, increasing privacy. |
| QuickSearchShowMiniMenu | 0 | Disables the mini menu for quick search, reducing distractions. |
| QuickViewOfficeFilesEnabled | 0 | Disables quick view for Office files in Edge. |
| RemoteDebuggingAllowed | 0 | Disables remote debugging, improving security. |
| RelatedMatchesCloudServiceEnabled | 0 | Disables the related matches cloud service, reducing data sent to Microsoft. |
| ResolveNavigationErrorsUseWebService | 0 | Disables use of web service to resolve navigation errors, reducing external data requests. |
| ShowAcrobatSubscriptionButton | 0 | Hides the Acrobat subscription button in Edge's PDF viewer. |
| SitePerProcess | 1 | Enables site isolation, running each site in its own process for security. |
| SuperDragDropEnabled | 0 | Disables Super Drag and Drop, preventing advanced drag-and-drop features. |
| TextPredictionEnabled | 0 | Disables text prediction, enhancing privacy. |
| UploadFromPhoneEnabled | 0 | Disables uploading from phone, restricting cross-device features. |
| VisualSearchEnabled | 0 | Disables Visual Search, preventing image-based search features. |
| WebRtcLocalhostIpHandling | DisableNonProxiedUdp | Prevents WebRTC from exposing local IP addresses unless proxied, enhancing privacy. |
| SmartScreenEnabled | 0 (Recommended) | Disables Microsoft Defender SmartScreen, which protects against malicious sites and downloads (user can override). |
| TyposquattingCheckerEnabled | 0 (Recommended) | Disables the Typosquatting Checker, which warns about potential typo-based phishing domains (user can override). |
| ScarewareBlockerProtectionEnabled | 0 (Recommended) | Disables Scareware Blocker Protection, which blocks scareware and misleading content (user can override). |

## Step 3: Applying a pre-configured Microsoft Edge profile
This step applies a [pre-configured profile available in this repository](https://github.com/azhcat/CutEdge/blob/main/edge-profile.zip). Full list of changes:
- Disabled bookmarks on start tab page;
- Disabled Copilot 'helper' features;
- Disabled opening websites in Internet Explorer mode;
- Disabled page preloading;
- Disabled saving cookies;
- Disabled sleeping tabs;
- English as preferred language.
