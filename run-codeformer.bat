@ECHO off
cls

set v_conda_env_name=codeformer
set v_conda_path=C:\Users\LocalAdmin\anaconda3

echo Environment name is set as %v_conda_env_name% 

cd "C:\Users\LocalAdmin\Downloads\GitHub\CodeFormer"

call "%v_conda_path%\Scripts\activate.bat" "%v_conda_env_name%"


echo                                      ---CODEFORMER---
echo.
:start
ECHO.
set /p "weight=Enter weight between 0 and 1 ex. 0.8 (or skip for default 0.7): " || SET "weight=0.7"
ECHO.
set choice=
ECHO.
ECHO 1. whole_images
ECHO 2. bg_upscale
ECHO 3. bg_and_face
ECHO 4. END 
ECHO.
set /p choice=Type the number of the job: 
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto whole_images
if '%choice%'=='2' goto bg_upscale
if '%choice%'=='3' goto bg_and_face
if '%choice%'=='4' goto end
ECHO "%choice%" is not valid, try again
goto start
ECHO.


:whole_images
call python inference_codeformer.py -w %weight% --input_path inputs\whole_imgs
start "" "C:\Users\LocalAdmin\Downloads\GitHub\CodeFormer\results\whole_imgs_%weight%\final_results"
goto end
:bg_upscale
call python inference_codeformer.py -w %weight% --input_path inputs\bg_upscale --bg_upsampler realesrgan
start "" "C:\Users\LocalAdmin\Downloads\GitHub\CodeFormer\results\bg_upscale_%weight%\final_results"
goto end
:bg_and_face
call python inference_codeformer.py -w %weight% --input_path inputs\bg_and_face --bg_upsampler realesrgan --face_upsample
start "" "C:\Users\LocalAdmin\Downloads\GitHub\CodeFormer\results\bg_and_face_%weight%\final_results"
goto end
:end
pause
