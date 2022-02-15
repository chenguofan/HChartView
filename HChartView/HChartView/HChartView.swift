//
//  HChartView.swift
//  wristBand
//
//  Created by suhengxian on 2021/12/14.
//

import UIKit

class HChartView: UIView{
    
    var indexPath:IndexPath?
    var maxValue:Float?
    var delegate:ChartViewProtocol?{
        willSet{
            self.delegate = newValue
        }
    }
    private let bottomLine = UIView()
    
    var topTitel:String?{
        willSet{
            self.topTitel = newValue
        }
        didSet{
            self.topLab.text = self.topTitel
        }
    }
    
    var xDatas:[String]?{
        willSet{
            //清除之前的view
            self.clearXDataView()
            self.xDatas = newValue
        }
        didSet{
            print("xData")
            self.createXView()
        }
    }
    var yDatas:[String]?{
        willSet{
            self.clearYDataView()
            self.yDatas = newValue
        }
        didSet{
            self.createYView()
        }
    }
    
    var valueDatas:[String]?{
        willSet{
            self.clearValueView()
            self.valueDatas = newValue
        }
        didSet{
            self.createValueView()
        }
    }
    private var topLab:UILabel = UILabel()
    private var moreBtn:UIButton = UIButton()
    
    private var firstLab:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("创建了几次");
        
        self.commitView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func clearXDataView(){
        guard (self.xDatas?.count) != nil else { return }
        for subView in self.subviews {
            if subView.tag >= 10  && subView.tag < 10 + (self.xDatas?.count ?? 0){
                subView.removeFromSuperview()
            }
            
            if subView.tag >= 100 && subView.tag < 100 + (self.xDatas?.count ?? 0){
                subView.removeFromSuperview()
            }
        }
    }
    
    private func createXView(){
        guard let count = self.xDatas?.count else { return }
        
        for index in 0...count-1{
            let lineView = UIView()
            lineView.backgroundColor = UIColor.white
            lineView.tag = 10 + index
            self.addSubview(lineView)
            
            let label = UILabel()
            label.text = self.xDatas![index]
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.tag = 100 + index
            self.addSubview(label)
        }
        
        self.bottomLine.backgroundColor = UIColor.white
        self.addSubview(self.bottomLine)
        
    }
    
    private func clearYDataView(){
        guard (self.yDatas?.count) != nil else { return }
        for subView in self.subviews {
            if subView.tag >= 1000  && subView.tag < 10000 + (self.yDatas?.count ?? 0){
                subView.removeFromSuperview()
            }
        }
    }
    
    private func createYView(){
        guard let count = self.yDatas?.count else{
            return
        }
        for index in 0...count-1 {
            let label = UILabel()
            label.text = self.yDatas![index]
            label.textColor = UIColor.white
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12.0)
            label.tag = 1000 + index
            label.sizeToFit()
            self.addSubview(label)
        }
    }
    
    private func clearValueView(){
        guard (self.valueDatas?.count) != nil else { return }
        for subView in self.subviews {
            if subView.tag >= 10000  && subView.tag < 10000 + (self.valueDatas?.count ?? 0){
                subView.removeFromSuperview()
            }
        }
    }
    
    private func createValueView(){
        guard let count = self.yDatas?.count else{
            return
        }
        
        for index in 0...count-1 {
            //创建横着的柱子
            let view = UIView()
            view.backgroundColor = UIColor.green
            view.tag = 10000 + index
            self.addSubview(view)
        }
    }
    
    private func commitView(){
        self.backgroundColor = UIColor.yellow
        
        self.topLab.font = UIFont.systemFont(ofSize: 15)
        self.topLab.textAlignment = .right
        self.topLab.textColor = UIColor.white
        self.topLab.text = self.topTitel
        self.addSubview(self.topLab)
        
        self.moreBtn.setTitle("查看更多", for: .normal)
        self.moreBtn.setTitle("查看更多", for: .selected)
        self.moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.moreBtn.setTitleColor(UIColor.white, for: .normal)
        self.moreBtn.setTitleColor(UIColor.white, for: .selected)
        self.moreBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        self.addSubview(self.moreBtn)
        
//        self.moreBtn.backgroundColor = UIColor.init(hexColor: "#225b7e")
        self.moreBtn.backgroundColor = UIColor.red
        
    }
    
    @objc func moreClick(){
        self.delegate?.clickMoreBtn(indexPath: self.indexPath ?? IndexPath.init(row: 0, section: 0))
    }
        
    override func layoutSubviews(){
        super.layoutSubviews()
        
        guard let count = self.xDatas?.count else { return }
        guard let count1 = self.yDatas?.count else { return }
        guard let count2 = self.valueDatas?.count else { return }
        
        //设置x轴数据的frame
        
        self.moreBtn.frame = CGRect.init(x:(self.width-140)/2.0, y:self.height-55, width: 140, height: 40)
        self.moreBtn.layer.cornerRadius = 20.0
        self.moreBtn.clipsToBounds = true
        
        self.topLab.frame = CGRect.init(x: 20, y: 15, width: self.width - 20 * 2, height: 30)
        
        let lineHeight = (self.moreBtn.frame.minY - 30.0 - 10.0 - self.topLab.frame.maxY - 10)
        
        let leftX = 50.0
        let rightX = 30.0
        let space = (self.width - leftX - rightX)/(CGFloat)(count - 1)
        
        let labWidth = 50.0
        let labHeight = 30.0
        
        for index in 0...count-1{
            let lineView = self.viewWithTag(10 + index)
            lineView!.frame = CGRect.init(x: leftX + space * (CGFloat)(index), y: self.topLab.y + self.topLab.height + 10.0, width: 0.8, height: lineHeight)
            
            let label = self.viewWithTag(100 + index)
            label!.frame = CGRect.init(x: leftX/2.0 + space * (CGFloat)(index), y: lineView!.y + lineView!.height, width: labWidth, height: labHeight)
        }
        
        self.bottomLine.frame = CGRect.init(x:leftX - 0.1, y:self.topLab.frame.maxY + 10 + lineHeight, width:self.width-leftX-rightX + 0.3, height:0.8)
        
        let squreHeight = 10.0
        
        let YHeight = (self.moreBtn.frame.minY - 30.0 - 10.0 - self.topLab.frame.maxY - 10 - 40)
        let labelHeight = YHeight/(CGFloat)(count1 - 1)
        //设置y轴的数据坐标
        for index in 0...count1 - 1 {
            let labl = self.viewWithTag(1000 + index)
            labl?.frame = CGRect.init(x: 0.0, y: 20 + self.topLab.bottom + labelHeight * (CGFloat(index)), width: labWidth, height:labelHeight)
        }
        
        for index in 0...count2 - 1 {
            let view = self.viewWithTag(10000 + index)
            //计算柱子的长度
            
            if self.maxValue == 0.0 || self.maxValue == nil{
                var max:Float = 0.0
                for item in self.valueDatas!{
                    if (item as NSString).floatValue > max{
                        max = ((item as NSString).floatValue)
                    }
                }
                self.maxValue = max
            }
            
            if self.maxValue == 0.0{
                return
            }
            
            let value = ((self.valueDatas?[index] ?? "0.0") as NSString).floatValue
            var viewWidth:CGFloat = (self.width - leftX - rightX)  * Double(value)/CGFloat(self.maxValue!) as CGFloat
            
            if viewWidth > (self.width - leftX - rightX){
                viewWidth = (self.width - leftX - rightX)
            }
            
            let topY:CGFloat = self.topLab.bottom + 20 + labelHeight/2.0 - squreHeight/2.0
            view!.frame = CGRect.init(x: labWidth + 0.8, y:topY + labelHeight * ((CGFloat)(index)), width: viewWidth, height: squreHeight)
            
        }
    }
}
