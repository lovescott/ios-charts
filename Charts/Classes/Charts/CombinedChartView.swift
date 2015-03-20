//
//  CombinedChartView.swift
//  Charts
//
//  Created by Daniel Cohen Gindi on 4/3/15.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation

/// This chart class allows the combination of lines, bars, scatter and candle data all displayed in one chart area.
public class CombinedChartView: BarLineChartViewBase
{
    /// the fill-formatter used for determining the position of the fill-line
    internal var _fillFormatter: ChartFillFormatter!
    
    /// enum that allows to specify the order in which the different data objects for the combined-chart are drawn
    @objc
    public enum DrawOrder: Int
    {
        case Bar
        case Line
        case Candle
        case Scatter
    }
    
    public override func initialize()
    {
        super.initialize();
        
        _fillFormatter = BarLineChartFillFormatter(chart: self);
        
        renderer = CombinedChartRenderer(chart: self, animator: _animator, viewPortHandler: _viewPortHandler);
    }
    
    override func calcMinMax()
    {
        super.calcMinMax();
        
        if (self.barData !== nil || self.candleData !== nil)
        {
            _chartXMin = -0.5;
            _chartXMax = Float(_data.xVals.count) - 0.5;
            _deltaX = CGFloat(abs(_chartXMax - _chartXMin));
        }
    }
    
    public override var data: ChartData?
    {
        get
        {
            return super.data;
        }
        set
        {
            super.data = newValue;
            (renderer as! CombinedChartRenderer?)?.createRenderers();
        }
    }
    
    public var fillFormatter: ChartFillFormatter
    {
        get
        {
            return _fillFormatter;
        }
        set
        {
            _fillFormatter = newValue;
            if (_fillFormatter === nil)
            {
                _fillFormatter = BarLineChartFillFormatter(chart: self);
            }
        }
    }
    
    public var lineData: LineChartData!
    {
        get
        {
            if (_data === nil)
            {
                return nil;
            }
            return (_data as! CombinedChartData!).lineData;
        }
    }
    
    public var barData: BarChartData!
    {
        get
        {
            if (_data === nil)
            {
                return nil;
            }
            return (_data as! CombinedChartData!).barData;
        }
    }
    
    public var scatterData: ScatterChartData!
    {
        get
        {
            if (_data === nil)
            {
                return nil;
            }
            return (_data as! CombinedChartData!).scatterData;
        }
    }
    
    public var candleData: CandleChartData!
    {
        get
        {
            if (_data === nil)
            {
                return nil;
            }
            return (_data as! CombinedChartData!).candleData;
        }
    }
    
    // MARK: Accessors
    
    /// flag that enables or disables the highlighting arrow
    public var drawHighlightArrowEnabled: Bool
    {
        get { return (renderer as! CombinedChartRenderer!).drawHighlightArrowEnabled; }
        set { (renderer as! CombinedChartRenderer!).drawHighlightArrowEnabled = newValue; }
    }
    
    /// if set to true, all values are drawn above their bars, instead of below their top
    public var drawValueAboveBarEnabled: Bool
        {
        get { return (renderer as! CombinedChartRenderer!).drawValueAboveBarEnabled; }
        set { (renderer as! CombinedChartRenderer!).drawValueAboveBarEnabled = newValue; }
    }
    
    /// if set to true, all values of a stack are drawn individually, and not just their sum
    public var drawValuesForWholeStackEnabled: Bool
    {
        get { return (renderer as! CombinedChartRenderer!).drawValuesForWholeStackEnabled; }
        set { (renderer as! CombinedChartRenderer!).drawValuesForWholeStackEnabled = newValue; }
    }
    
    /// if set to true, a grey area is darawn behind each bar that indicates the maximum value
    public var drawBarShadowEnabled: Bool
    {
        get { return (renderer as! CombinedChartRenderer!).drawBarShadowEnabled; }
        set { (renderer as! CombinedChartRenderer!).drawBarShadowEnabled = newValue; }
    }
    
    /// returns true if drawing the highlighting arrow is enabled, false if not
    public var isDrawHighlightArrowEnabled: Bool { return (renderer as! CombinedChartRenderer!).drawHighlightArrowEnabled; }
    
    /// returns true if drawing values above bars is enabled, false if not
    public var isDrawValueAboveBarEnabled: Bool { return (renderer as! CombinedChartRenderer!).drawValueAboveBarEnabled; }
    
    /// returns true if all values of a stack are drawn, and not just their sum
    public var isDrawValuesForWholeStackEnabled: Bool { return (renderer as! CombinedChartRenderer!).drawValuesForWholeStackEnabled; }
    
    /// returns true if drawing shadows (maxvalue) for each bar is enabled, false if not
    public var isDrawBarShadowEnabled: Bool { return (renderer as! CombinedChartRenderer!).drawBarShadowEnabled; }
    
    /// the order in which the provided data objects should be drawn.
    /// The earlier you place them in the provided array, the further they will be in the background. 
    /// e.g. if you provide [DrawOrder.Bar, DrawOrder.Line], the bars will be drawn behind the lines.
    public var drawOrder: [Int]
    {
        get
        {
            return (renderer as! CombinedChartRenderer!).drawOrder.map { $0.rawValue };
        }
        set
        {
            (renderer as! CombinedChartRenderer!).drawOrder = newValue.map { DrawOrder(rawValue: $0)! };
        }
    }
}