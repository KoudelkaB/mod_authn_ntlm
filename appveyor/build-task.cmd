@echo off
setlocal enableextensions enabledelayedexpansion
	cd /d %APPVEYOR_BUILD_FOLDER%\build

	cmake -G %GENERATOR% -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% ..
	cmake --build . --config %CMAKE_BUILD_TYPE%

	if not exist "%APPVEYOR_BUILD_FOLDER%\build\%CMAKE_BUILD_TYPE%\mod_authn_ntlm.dll" exit /b 3

	move "%APPVEYOR_BUILD_FOLDER%\build\%CMAKE_BUILD_TYPE%\mod_authn_ntlm.dll" "%APPVEYOR_BUILD_FOLDER%\build\%CMAKE_BUILD_TYPE%\mod_authn_ntlm.so"

	xcopy %APPVEYOR_BUILD_FOLDER%\build\%CMAKE_BUILD_TYPE% %APPVEYOR_BUILD_FOLDER%\artifacts\%CMAKE_BUILD_TYPE%\ /y /f

	xcopy %APPVEYOR_BUILD_FOLDER%\README.md %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\ /y /f
	xcopy %APPVEYOR_BUILD_FOLDER%\copyright.txt %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\ /y /f
	xcopy %APPVEYOR_BUILD_FOLDER%\CMakeLists.txt %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\ /y /f
	xcopy %APPVEYOR_BUILD_FOLDER%\conf %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\conf\ /y /f
	xcopy %APPVEYOR_BUILD_FOLDER%\src %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\conf\ /y /f
	xcopy %APPVEYOR_BUILD_FOLDER%\build\%CMAKE_BUILD_TYPE%\* %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\bin\ /y /f
	7z a mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%.zip %APPVEYOR_BUILD_FOLDER%\mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%\*
	appveyor PushArtifact mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%.zip -FileName mod_authn_ntlm-%APPVEYOR_REPO_TAG_NAME%-%ARCHITECTURE%-%BUILD_CRT%-%CMAKE_BUILD_TYPE%.zip

endlocal
