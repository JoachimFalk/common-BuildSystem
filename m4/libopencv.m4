dnl -*- tab-width:8; indent-tabs-mode:nil; -*-
dnl vim: set sw=2 ts=8 sts=2 syn=config et:
dnl
dnl Copyright (c)
dnl   2010 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2014 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2015 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl   2023 FAU -- Joachim Falk <joachim.falk@fau.de>
dnl 
dnl This file is part of the BuildSystem distribution of Joachim Falk;
dnl you can redistribute it and/or modify it under the terms of the
dnl GNU General Public License as published by the Free Software Foundation;
dnl either version 2 of the License, or (at your option) any later version.
dnl 
dnl The BuildSystem is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
dnl General Public License for more details.
dnl 
dnl You should have received a copy of the GNU General Public
dnl License along with this program; If not, write to
dnl the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
dnl Boston, MA 02111-1307, USA.

dnl ACJF_CHECK_LIB_OPENCV(
dnl  [<code if found, default does nothing>,
dnl  [<code if not found, default is bailout>]])
dnl
dnl check for systemc library
AC_DEFUN([ACJF_CHECK_LIB_OPENCV], [
AC_LANG_PUSH([C++])
ACJF_CHECK_LIB(
  [OpenCV],
  [[extern],[pkgconfig:opencv4 >= 4.5]],
  [
#include <opencv2/videoio.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>

#include <iostream>
#include <cerrno>
#include <cstring>
  ],[
  cv::VideoCapture capture;

  const char *input = "flummy.avi";
  capture.open(input);
  if (!capture.isOpened()) {
    std::cerr << "Can't open file \"" << input << "\": " << strerror(errno) << std::endl;
    return -1;
  }
  cv::namedWindow("output", cv::WINDOW_AUTOSIZE);
  cv::Mat img;
  while (true) {
    capture >> img;
    size_t width  = img.cols;
    size_t height = img.rows;
    std::cout << "Got image of dimension " << width << "x" << height << "!" << std::endl;
    if (img.empty())
      break;
    cv::cvtColor(img, img, cv::COLOR_BGR2RGB);
    cv::imshow("output", img);
    cv::waitKey(25);
  }
  return 0;
  ],
  [$1], [$2])
AC_LANG_POP
])
