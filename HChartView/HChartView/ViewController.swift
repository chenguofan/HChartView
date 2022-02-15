//
//  ViewController.swift
//  HChartView
//
//  Created by suhengxian on 2022/2/15.
//

import UIKit

class ViewController: UIViewController,ChartViewProtocol{
    func clickMoreBtn(indexPath: IndexPath) {
        print("hello world")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hChartView = HChartView.init(frame: CGRect.init(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: 400))
        hChartView.delegate = self
        self.view.addSubview(hChartView)
        
        hChartView.topTitel = "hello world"
        hChartView.maxValue = 50.0
        hChartView.yDatas = ["6月","7月","8月","9月","10月","11月"];
        hChartView.xDatas = ["0h","4","8","12","16","20"]
        hChartView.valueDatas = ["10.0","20.0","30.0","40.0","80.0","50.0"];
        hChartView.maxValue = 40.0

    }


}

