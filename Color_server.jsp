<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="javax.imageio.*"%>
<%@ page import="java.awt.image.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Color Image Processing - Server (RC 1)</title>
</head>
<body>
	<%!///////////////////////
	// 전역 변수부
	///////////////////////
	int[][][] inImage;
	int inH, inW;
	int[][][] outImage;
	int outH, outW;
	File inFp, outFp;

	// Parameter Variable
	String algo, para1, para2;
	String inFname, outFname;

	///////////////////////
	// 영상처리 함수부
	///////////////////////
	/////(1) 화소점 처리(Pixel Processing)
	public void equalImage() {
		// 동일 영상
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = inImage[rgb][i][k];
				}
			}
		}
	}

	public void reverseImage() {
		// 반전 영상
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = 255 - inImage[rgb][i][k];
				}
			}
		}
	}

	public void addImage() {
		// 밝게하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int value = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					if (inImage[rgb][i][k] + value > 255)
						outImage[rgb][i][k] = 255;
					else
						outImage[rgb][i][k] = inImage[rgb][i][k] + value;
				}
			}
		}
	}

	public void subImage() {
		// 어둡게하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int value = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					if (inImage[rgb][i][k] - value < 0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = inImage[rgb][i][k] - value;
				}
			}
		}
	}

	public void mulImage() {
		// 곱하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int value = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					if (inImage[rgb][i][k] * value > 255)
						outImage[rgb][i][k] = 255;
					else
						outImage[rgb][i][k] = inImage[rgb][i][k] * value;
				}
			}
		}
	}

	public void divImage() {
		// 나누기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int value = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = inImage[rgb][i][k] / value;
				}
			}
		}
	}

	public void black127Image() {
		// 흑백(127기준)
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for(int i=0;i<inH;i++){
		for(int k=0;k<inW;k++){
			int sumValue = inImage[0][i][k]+inImage[1][i][k]+inImage[2][i][k];
			int avgValue = sumValue/3;
			
			if(avgValue>127){
				outImage[0][i][k]=255;
				outImage[1][i][k]=255;
				outImage[2][i][k]=255;
			}
			else{
				outImage[0][i][k]=0;
				outImage[1][i][k]=0;
				outImage[2][i][k]=0;
			}
		}
	}
}

	public void blackAvgImage() {
		// 흑백(평균기준)
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int sum = 0;
		int cnt = 0;
		int avg = 0;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					sum += inImage[rgb][i][k];
					cnt++;
				}
			}
		}
		avg = sum/cnt;
		
		for(int i=0;i<inH;i++){
			for(int k=0;k<inW;k++){
				int sumValue = inImage[0][i][k]+inImage[1][i][k]+inImage[2][i][k];
				int avgValue = sumValue/3;
				
				if(avgValue>avg){
					outImage[0][i][k]=255;
					outImage[1][i][k]=255;
					outImage[2][i][k]=255;
				}
					
				else{
					outImage[0][i][k]=0;
					outImage[1][i][k]=0;
					outImage[2][i][k]=0;
				}
			}
		}
	}

	public void pbCapImage() {
		// 파라볼라(캡)
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k]=(int)(255-(255)*Math.pow((double)(inImage[rgb][i][k]/128-1),(double)2));
				}
			}
		}
	}

	public void pbCupImage() {
		// 파라볼라(컵)
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k]=(int)(Math.pow((double)(inImage[rgb][i][k]/128-1),(double)2)*255);
				}
			}
		}
	}

	public void gammaImage() {
		// 감마보정 알고리즘
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		double value = Double.parseDouble(para1);
		if (value < 0)
			value = 1 / (1 - value);
		else
			value += 1;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = (int) (255 * Math.pow((inImage[rgb][i][k] / 255.0), value));
				}
			}
		}
	}

	/////(2) 기하학 처리(Geometry Processing)
	public void upDownImage() {
		// 상하미러링
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int i = 0; i < inH; i++) {
			for (int k = 0; k < inW; k++) {
				outImage[0][i][k] = inImage[0][i][inW - k - 1];
				outImage[1][i][k] = inImage[1][i][inW - k - 1];
				outImage[2][i][k] = inImage[2][i][inW - k - 1];
			}
		}
	}

	public void leftRightImage() {
		// 좌우미러링
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		for (int i = 0; i < inH; i++) {
			for (int k = 0; k < inW; k++) {
				outImage[0][i][k] = inImage[0][inH - i - 1][k];
				outImage[1][i][k] = inImage[1][inH - i - 1][k];
				outImage[2][i][k] = inImage[2][inH - i - 1][k];
			}
		}
	}

	public void zoomOutImage() {
		// 축소하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int scale = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][(int) (i / scale)][(int) (k / scale)] = inImage[rgb][i][k];
				}
			}
		}
	}

	public void zoomInImage() {
		// 확대하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int scale = Integer.parseInt(para1);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = inImage[rgb][(int) (i / scale)][(int) (k / scale)];
				}
			}
		}
	}

	public void moveImage() {
		// 이동하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int x = Integer.parseInt(para1);
		int y = Integer.parseInt(para2);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					if (i + y < outH && k + x < outW)
						outImage[rgb][i + y][k + x] = inImage[rgb][i][k];
					else
						break;
				}
			}
		}
	}

	public void rotateImage() {
		// 회전하기
		// (중요!) 출력 영상의 크기 결정 (알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		/// ** Image Processing Algorithm **
		int degree = Integer.parseInt(para1);
		double radian = degree * Math.PI / 180.0;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[rgb][i][k] = 255;
				}
			}
		}
		int xin, yin;
		int cx = (int) (outH / 2);
		int cy = (int) (outW / 2);
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					xin = (int) (Math.cos(radian) * (i - cy) - Math.sin(radian) * (k - cx) + cy);
					yin = (int) (Math.sin(radian) * (i - cy) + Math.cos(radian) * (k - cx) + cx);

					if ((0 <= xin && xin < inH) && (0 <= yin && yin < inW))
						outImage[rgb][i][k] = inImage[rgb][xin][yin];
				}
			}
		}
	}

	/////(3) 화소영역 처리(Area Processing)
	public void embossImage() {
		// 엠보싱
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { -1.0, 0.0, 0.0 }, { 0.0, 0.0, 0.0 }, { 0.0, 0.0, 1.0 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
					;
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		//sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}

	}

	public void blurrImage() {
		// 엠보싱
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 1.0 / 9, 1.0 / 9, 1.0 / 9 }, { 1.0 / 9, 1.0 / 9, 1.0 / 9 },
				{ 1.0 / 9, 1.0 / 9, 1.0 / 9 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void gaussianImage() {
		// 가우시안 필터
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 1.0 / 16, 1.0 / 8, 1.0 / 16 }, { 1.0 / 8, 1.0 / 4, 1.0 / 8 },
				{ 1.0 / 16, 1.0 / 8, 1.0 / 16 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void sharpeningImage() {
		// 샤프닝
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0.0, -1.0, 0.0 }, { -1.0, 5.0, -1.0 }, { 0.0, -1.0, 0.0 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void highSharpeningImage() {
		// 고주파 필터 샤프닝
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { -1.0 / 9, -1.0 / 9, -1.0 / 9 }, { -1.0 / 9, 8.0 / 9, -1.0 / 9 },
				{ -1.0 / 9, -1.0 / 9, -1.0 / 9 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}
		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		//sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void lowSharpeningImage() {
		// 저주파 필터 샤프닝
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 1.0 / 9, 1.0 / 9, 1.0 / 9 }, { 1.0 / 9, 1.0 / 9, 1.0 / 9 },
				{ 1.0 / 9, 1.0 / 9, 1.0 / 9 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void boundaryImage() {
		// 경계선 검출
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] maskW = { { -1.0, -1.0, -1.0 }, { 0.0, 0.0, 0.0 }, { 1.0, 1.0, 1.0 } };
		double[][] maskH = { { 1.0, 0.0, -1.0 }, { 1.0, 0.0, -1.0 }, { 1.0, 0.0, -1.0 } };

		double[][][] tmpInImageW = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImageW = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImageW[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImageW[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImageW[rgb][i + m][k + n] * maskW[m][n];
					tmpOutImageW[rgb][i][k] = (int) S;
				}
			}
		}

		double[][][] tmpInImageH = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImageH = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImageH[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImageH[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImageH[rgb][i + m][k + n] * maskH[m][n];
					tmpOutImageH[rgb][i][k] = (int) S;
				}
			}
		}
		double[][][] tmpOutImage = new double[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < inH; i++)
				for (int k = 0; k < inW; k++)
					tmpOutImage[rgb][i][k] = Math
							.sqrt(Math.pow(tmpOutImageW[rgb][i][k], 2) + Math.pow(tmpOutImageH[rgb][i][k], 2));
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void homogenImage() {
		// 유사 연산자
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}
		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double max = 0.0;
					double pixel;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++) {
							pixel = Math.abs(tmpInImage[rgb][i + 1][k + 1] - tmpInImage[rgb][i + m][k + n]);
							if (pixel >= max)
								max = pixel;
						}
					outImage[rgb][i][k] = (int) max;
					if (outImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (outImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) outImage[rgb][i][k];
				}
			}
		}
	}

	public void differenceImage() {
		// 차 연산자
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}
		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double max = 0.0;
					double pixel;
					pixel = Math.abs(tmpInImage[rgb][i + 0][k + 0] - tmpInImage[rgb][i + 2][k + 2]);
					if (pixel >= max)
						max = pixel;
					pixel = Math.abs(tmpInImage[rgb][i + 0][k + 1] - tmpInImage[rgb][i + 2][k + 1]);
					if (pixel >= max)
						max = pixel;
					pixel = Math.abs(tmpInImage[rgb][i + 1][k + 2] - tmpInImage[rgb][i + 1][k + 0]);
					if (pixel >= max)
						max = pixel;

					outImage[rgb][i][k] = (int) max;
					if (outImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (outImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) outImage[rgb][i][k];
				}
			}
		}
	}

	public void LoGImage() {
		// LoG 알고리즘
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0., 0., -1., 0., 0. }, { 0., -1., -2., -1., 0. }, { -1., -2., 16., -2., -1. },
				{ 0., -1., -2., -1., 0. }, { 0., 0., -1., 0., 0. } };

		double[][][] tmpInImage = new double[3][outH + 4][outW + 4];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 2][k + 2] = inImage[rgb][i][k];
				}
			}
		}
		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 5; m++)
						for (int n = 0; n < 5; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		//sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void DoGImage() {
		// DoG 알고리즘
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0., 0., -1., -1., -1., 0., 0. }, { 0., -2., -3, -3, -3, -2., 0. },
				{ -1., -3., 5., 5., 5., -3., -1. }, { -1., -3., 5., 16., 5., -3., -1. },
				{ -1., -3., 5., 5., 5., -3., -1. }, { 0., -2., -3, -3, -3, -2., 0. },
				{ 0., 0., -1., -1., -1., 0., 0. } };

		double[][][] tmpInImage = new double[3][outH + 6][outW + 6];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 3][k + 3] = inImage[rgb][i][k];
				}
			}
		}
		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 7; m++)
						for (int n = 0; n < 7; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		//sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void laplacianImage() {
		// 라플라시안
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0., -1., 0. }, { -1., 4., -1. }, { 0., -1., 0. } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		// //sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void robertsImage() {
		// 로버츠 마스크
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { -1.0, 0.0, -1.0 }, { 0.0, 2.0, 0.0 }, { 0.0, 0.0, 0.0 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		// //sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void sobelImage() {
		// 소벨 마스크
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0.0, -2.0, -2.0 }, { 2.0, 0.0, -2.0 }, { 2.0, 2.0, 0.0 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		// //sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	public void prewittImage() {
		// 프리윗 마스크
		// (중요!) 출력 영상의 크기 결정(알고리즘에 의존)
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];

		double[][] mask = { { 0.0, -1.0, -2.0 }, { 1.0, 0.0, -1.0 }, { 2.0, 1.0, 0.0 } };

		double[][][] tmpInImage = new double[3][outH + 2][outW + 2];

		int[][][] tmpOutImage = new int[3][outH][outW];
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH + 2; i++) {
				for (int k = 0; k < inW + 2; k++) {
					tmpInImage[rgb][i][k] = 127.0;
				}
			}
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					tmpInImage[rgb][i + 1][k + 1] = inImage[rgb][i][k];
				}
			}
		}

		//** Image Processing Algorithm **
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					double S = 0.0;
					for (int m = 0; m < 3; m++)
						for (int n = 0; n < 3; n++)
							S += tmpInImage[rgb][i + m][k + n] * mask[m][n];
					tmpOutImage[rgb][i][k] = (int) S;
				}
			}
		}
		// //sum=0
		for (int rgb = 0; rgb < 3; rgb++)
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++)
					tmpOutImage[rgb][i][k] += 127.0;

		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < outH; i++)
				for (int k = 0; k < outW; k++) {
					if (tmpOutImage[rgb][i][k] > 255.0)
						outImage[rgb][i][k] = 255;
					else if (tmpOutImage[rgb][i][k] < 0.0)
						outImage[rgb][i][k] = 0;
					else
						outImage[rgb][i][k] = (int) tmpOutImage[rgb][i][k];
				}
		}
	}

	/////(4) 히스토그램 처리(Histogram Processing)
	public void stretchImage() {
		//스트레칭
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		//** Image Processing Algorithm **
		int LOW = inImage[0][0][0],HIGH=inImage[0][0][0];
		for(int rgb=0;rgb<3;rgb++){
			for(int i=0;i<inH;i++)
				for(int k=0;k<inW;k++){
					if(LOW>inImage[rgb][i][k])
						LOW = inImage[rgb][i][k];
					if(HIGH<inImage[rgb][i][k])
						HIGH=inImage[rgb][i][k];
				}
		}
		
		LOW += 50;
		HIGH += 50;
		
		for(int rgb=0;rgb<3;rgb++){
			for(int i=0;i<inH;i++){
				for(int k=0;k<inW;k++){
					double out = (double)((inImage[rgb][i][k]-LOW)*255/(HIGH-LOW));
					if(out<0.0)
						out=0;
					else if(out>255.0)
						out=255;
					else
						out=(int)out;
					outImage[rgb][i][k] = (int)out;
				}
			}
		}
	}

	public void endInImage() {
		//엔드-인
		outH = inH;
		outW = inW;
		outImage = new int[3][outH][outW];
		//** Image Processing Algorithm **
		int LOW = inImage[0][0][0],HIGH=inImage[0][0][0];
		for(int rgb=0;rgb<3;rgb++){
			for(int i=0;i<inH;i++)
				for(int k=0;k<inW;k++){
					if(LOW>inImage[rgb][i][k])
						LOW = inImage[rgb][i][k];
					if(HIGH<inImage[rgb][i][k])
						HIGH=inImage[rgb][i][k];
				}
		}
		for(int rgb=0;rgb<3;rgb++){
			for(int i=0;i<inH;i++){
				for(int k=0;k<inW;k++){
					double out = (double)((inImage[rgb][i][k]-LOW)*255/(HIGH-LOW));
					if(out<0.0)
						out=0;
					else if(out>255.0)
						out=255;
					else
						out=(int)out;
					outImage[rgb][i][k] = (int)out;
				}
			}
		}
	}

	public void equalizeImage() {
		//평활화
		outH = inH;
		outW = inW;

		outImage = new int[3][outH][outW];

		int histoR[] = new int[256];
		int histoG[] = new int[256];
		int histoB[] = new int[256];

		for (int i = 0; i < 256; i++) {
			histoR[i] = 0;
			histoG[i] = 0;
			histoB[i] = 0;
		}

		for (int i = 0; i < inH; i++)
			for (int k = 0; k < inW; k++) {
				histoR[inImage[0][i][k]]++;
				histoG[inImage[1][i][k]]++;
				histoB[inImage[2][i][k]]++;
			}

		int sumHistoR[] = new int[256];
		int sumHistoG[] = new int[256];
		int sumHistoB[] = new int[256];

		for (int i = 0; i < 256; i++) {
			sumHistoR[i] = 0;
			sumHistoG[i] = 0;
			sumHistoG[i] = 0;
		}

		int sumValueR = 0;
		int sumValueG = 0;
		int sumValueB = 0;

		for (int i = 0; i < 256; i++) {
			sumValueR += histoR[i];
			sumHistoR[i] = sumValueR;

			sumValueG += histoG[i];
			sumHistoG[i] = sumValueG;

			sumValueB += histoB[i];
			sumHistoB[i] = sumValueB;

		}

		double normalHistoR[] = new double[256];
		double normalHistoG[] = new double[256];
		double normalHistoB[] = new double[256];

		for (int i = 0; i < 256; i++) {
			normalHistoR[i] = 0.0;
			normalHistoG[i] = 0.0;
			normalHistoB[i] = 0.0;
		}

		for (int i = 0; i < 256; i++) {
			double normalR = sumHistoR[i] * (1.0 / (inH * inW)) * 255.0;
			normalHistoR[i] = normalR;
			double normalG = sumHistoG[i] * (1.0 / (inH * inW)) * 255.0;
			normalHistoG[i] = normalG;
			double normalB = sumHistoB[i] * (1.0 / (inH * inW)) * 255.0;
			normalHistoB[i] = normalB;
		}
		for (int rgb = 0; rgb < 3; rgb++) {
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					outImage[0][i][k] = (int) normalHistoR[inImage[0][i][k]];
					outImage[1][i][k] = (int) normalHistoG[inImage[1][i][k]];
					outImage[2][i][k] = (int) normalHistoB[inImage[2][i][k]];
				}
			}
		}
	}%>
	<%
		///////////////////////
		// 메인 코드부
		///////////////////////
		// (0) 파라미터 넘겨 받기
		MultipartRequest multi = new MultipartRequest(request, "C:/Upload", 5 * 1024 * 1024, "utf-8",
				new DefaultFileRenamePolicy());

		String tmp;
		Enumeration params = multi.getParameterNames(); // 주의! 파라미터 순서가 반대
		tmp = (String) params.nextElement();
		para2 = multi.getParameter(tmp);
		tmp = (String) params.nextElement();
		para1 = multi.getParameter(tmp);
		tmp = (String) params.nextElement();
		algo = multi.getParameter(tmp);

		// File
		Enumeration files = multi.getFileNames(); // 여러개 파일
		tmp = (String) files.nextElement(); // 첫 파일 한개
		String filename = multi.getFilesystemName(tmp); // 파일명을 추출

		// algo = request.getParameter("algo");
		// para1 = request.getParameter("para1");
		// para2 = request.getParameter("para2");
		// inFname = request.getParameter("inFname");
		// outFname = request.getParameter("outFname");

		// (1)입력 영상 파일 처리
		inFp = new File("c:/Upload/" + filename);
		BufferedImage bImage = ImageIO.read(inFp);

		// (2) 파일 --> 메모리
		// (중요!) 입력 영상의 폭과 높이를 알아내야 함!
		inW = bImage.getHeight();
		inH = bImage.getWidth();

		// 메모리 할당
		inImage = new int[3][inH][inW];

		// 읽어오기
		for (int i = 0; i < inH; i++) {
			for (int k = 0; k < inW; k++) {
				int rgb = bImage.getRGB(i, k); // F377D6 
				int r = (rgb >> 16) & 0xFF; // >>2Byte --->0000F3 & 0000FF --> F3
				int g = (rgb >> 8) & 0xFF; // >>1Byte --->00F377 & 0000FF --> 77			
				int b = (rgb >> 0) & 0xFF; // >>0Byte --->F377D6 & 0000FF --> D6
				inImage[0][i][k] = r;
				inImage[1][i][k] = g;
				inImage[2][i][k] = b;
			}
		}

		// Image Processing
		switch (algo) {
		case "101": // 동일영상
			equalImage();
			break;
		case "102": // 반전 영상
			reverseImage();
			break;
		case "103": // 밝게하기
			addImage();
			break;
		case "104": // 어둡게하기
			subImage();
			break;
		case "105": // 곱하기
			mulImage();
			break;
		case "106": // 나누기
			divImage();
			break;
		case "107": // 흑백(127기준)
			black127Image();
			break;
		case "108": // 흑백(평균기준)
			blackAvgImage();
			break;
		case "109": // 파라볼라(캡)
			pbCapImage();
			break;
		case "110": // 파라볼라(캡)
			pbCupImage();
			break;
		case "111": // 감마
			gammaImage();
			break;

		case "201": // 상하 미러링
			upDownImage();
			break;
		case "202": // 좌우 미러링
			leftRightImage();
			break;
		case "203": // 축소하기
			zoomOutImage();
			break;
		case "204": // 확대하기
			zoomInImage();
			break;
		case "205": // 이동하기
			moveImage();
			break;
		case "206": // 회전하기
			rotateImage();
			break;


		case "301": // 엠보싱
			embossImage();
			break;
		case "302": // 블러링
			blurrImage();
			break;
		case "303": // 가우시안 필터
			gaussianImage();
			break;
		case "304": // 샤프닝
			sharpeningImage();
			break;
		case "305": // 고주파 필터 샤프닝
			highSharpeningImage();
			break;
		case "306": // 저주파 필터 샤프닝
			lowSharpeningImage();
			break;
		case "307": // 경계선 검출
			boundaryImage();
			break;
		case "308": // 유사 연산자
			homogenImage();
			break;
		case "309": // 차 연산자
			differenceImage();
			break;
		case "310": // LoG
			LoGImage();
			break;
		case "311": // DoG
			DoGImage();
			break;
		case "312": // 라플라시안
			laplacianImage();
			break;
		case "313": // 로버츠 마스크
			robertsImage();
			break;
		case "314": // 소벨 마스크
			sobelImage();
			break;
		case "315": // 프리윗 마스크
			prewittImage();
			break;

		case "401": // 히스토그램 스트래칭
			stretchImage();
			break;
		case "402": // 엔드-인 탐색
			endInImage();
			break;
		case "403": // 히스토그램 평활화
			equalizeImage();
			break;

		}

		//(4) 결과를 파일로 저장하기
		outFp = new File("c:/out/out_" + filename);
		BufferedImage oImage = new BufferedImage(outH, outW, BufferedImage.TYPE_INT_RGB); // Empty Image
		//Memory --> File
		for (int i = 0; i < inH; i++) {
			for (int k = 0; k < inW; k++) {
				int r = outImage[0][i][k]; // F3
				int g = outImage[1][i][k]; // 77
				int b = outImage[2][i][k]; // D6
				int px = 0;
				px = px | (r << 16); // 000000 | (F30000) --> F30000
				px = px | (g << 8); // F30000 | (007700) --> F37700
				px = px | (b << 0); // F37700 | (0000D6) --> F377D6
				oImage.setRGB(i, k, px);
			}
		}
		ImageIO.write(oImage, "jpg", outFp);

		out.println("<h1>" + filename + " 영상 처리 완료 !! </h1>");
		String url = "<p><h2><a href='http://192.168.56.101:8080/";
		url += "ColorImageProcessing/download.jsp?file=";
		url += "out_" + filename + "'> ** 다운로드 ** </a></h2>";

		out.println(url);
	%>
</body>
</html>