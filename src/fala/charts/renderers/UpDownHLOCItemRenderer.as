package fala.charts.renderers
{
	import flash.display.Graphics;
	
	import mx.charts.ChartItem;
	import mx.charts.renderers.HLOCItemRenderer;
	import mx.charts.series.items.HLOCSeriesItem;
	import mx.graphics.IStroke;
	import mx.graphics.LinearGradientStroke;
	import mx.graphics.Stroke;
	import mx.styles.StyleManager;
	import mx.utils.ColorUtil;
	

	public class UpDownHLOCItemRenderer extends HLOCItemRenderer
	{
		
		/**
	     *  @private
	     *  Storage for the data property.
	     */
	    private var _chartItem:HLOCSeriesItem;
	
	    [Inspectable(environment="none")]
	    
        /**
		 *  The chart item that this renderer represents.
		 *  HLOCItemRenderers assume this value
		 *  is an instance of HLOCSeriesItem.
		 *  This value is assigned by the owning series.
		 */
		override public function get data():Object
		{
		    return _chartItem;
		}
		
		/**
		 *  @private
		 */
		override public function set data(value:Object):void
		{
		    _chartItem = value as HLOCSeriesItem;
		
		    invalidateDisplayList();
		}
	
		
		public function UpDownHLOCItemRenderer()
		{
			//TODO: implement function
			super();
		}
		
		
		/**
	     *  @private
	     */
	    override protected function updateDisplayList(unscaledWidth:Number,
	                                                  unscaledHeight:Number):void
	    {
	        super.updateDisplayList(unscaledWidth, unscaledHeight);
	
	        var istroke:IStroke = getStyle("stroke");
	        
	        var upcolor:uint = getStyle("upColor");
	        var downcolor:uint = getStyle("downColor"); 
	        
	        if (!upcolor)
	        	upcolor = 0x00CC00;
	       	if (!downcolor)
	       		downcolor = 0xEE0000;
	        
	        var stroke:Stroke;
	        var lgstroke:LinearGradientStroke;
	        
	        if(istroke is Stroke)
	        	stroke = Stroke(istroke);
	        else if(istroke is LinearGradientStroke)
	        	lgstroke = LinearGradientStroke(istroke);
	        else
	        	stroke = new Stroke(getStyle('hlocColor'), istroke.weight);
	        
	        var iOpenTickStroke:IStroke = getStyle("openTickStroke");
	        
	        var openTickStroke:Stroke;
	        var lgOpenTickStroke:LinearGradientStroke;
	        
	        if(iOpenTickStroke is Stroke)
	        	openTickStroke = Stroke(iOpenTickStroke);
	       else if(iOpenTickStroke is LinearGradientStroke)
	        	lgOpenTickStroke = LinearGradientStroke(iOpenTickStroke);
	        else
	        	openTickStroke = new Stroke(getStyle('hlocColor'), iOpenTickStroke.weight, 1, false, "normal", "none");
	        	
	        var iCloseTickStroke:IStroke = getStyle("closeTickStroke");
	        
	        var closeTickStroke:Stroke;
	        var lgCloseTickStroke:LinearGradientStroke;
	        
	        if(iCloseTickStroke is Stroke)
	        	closeTickStroke = Stroke(iCloseTickStroke);
	        else if(iCloseTickStroke is LinearGradientStroke)
	        	lgCloseTickStroke = LinearGradientStroke(iCloseTickStroke);
	        else
	        	closeTickStroke = new Stroke(getStyle('hlocColor'), iCloseTickStroke.weight, 1, false, "normal", "none");
	        	
	        var w2:Number = unscaledWidth / 2;
	
	        var openTickLen:Number = Math.min(w2, getStyle("openTickLength"));
	        var closeTickLen:Number = Math.min(w2, getStyle("closeTickLength"));
	        
	        var openTick:Number;
	        var closeTick:Number;
	        
	        var state:String = "";
	        var oldColor:uint;
	        var oldOpenTickColor:uint;
	        var oldCloseTickColor:uint;
	        var strokeColor:uint;
	        var openTickColor:uint;
	        var closeTickColor:uint;
	                
	        if (_chartItem)
	        {
	            var lowValue:Number = Math.max(_chartItem.low,Math.max(_chartItem.high,_chartItem.close));
	            var highValue:Number = Math.min(_chartItem.low,Math.min(_chartItem.high,_chartItem.close));
	            
	            var openValue:Number = _chartItem.open;
	            var closeValue:Number = _chartItem.close;
	            
	            if(!isNaN(_chartItem.open)) 
	            {
	                lowValue = Math.max(lowValue,_chartItem.open);
	                highValue = Math.min(highValue,_chartItem.open);
	            }
	    
	            var HLOCHeight:Number = lowValue - highValue;
	            var heightScaleFactor:Number = (HLOCHeight > 0)? (height / HLOCHeight):0;
	
	            openTick = (_chartItem.open - highValue) *
	                       heightScaleFactor;
	            closeTick = (_chartItem.close - highValue) *
	                        heightScaleFactor;
	            
	            state = _chartItem.currentState;
	            
	            if(state && state != "")
	        	{
	        		if(stroke)
	        		{
			         	strokeColor = (closeValue < openValue) ? upcolor : downcolor;
	               		oldColor = stroke.color;
	          		}
	            	else if(lgstroke.entries.length > 0)
	            	{
	            		strokeColor = lgstroke.entries[0].color;
	            		oldColor = lgstroke.entries[0].color;
	            	}	
	            	if(openTickStroke)
	            	{
	            		openTickColor = (closeValue < openValue) ? upcolor : downcolor;
	            		oldOpenTickColor = openTickStroke.color;
	            	}
	            	else if(lgOpenTickStroke.entries.length > 0)
	            	{
	                	openTickColor = lgOpenTickStroke.entries[0].color;
	                	oldOpenTickColor = lgOpenTickStroke.entries[0].color;
	             	}
	            	if(closeTickStroke)
	            	{
	                	closeTickColor = (closeValue < openValue) ? upcolor : downcolor;
	                	oldCloseTickColor = closeTickStroke.color;
	             	}
	            	else if(lgCloseTickStroke.entries.length > 0)
	            	{
	                	closeTickColor = lgCloseTickStroke.entries[0].color;
	                	oldCloseTickColor = lgCloseTickStroke.entries[0].color;
	             	}           
	         	}
	         	
	         	     
	            switch(state)
	            {
	                case ChartItem.FOCUSED:
	                case ChartItem.ROLLOVER:
	                    if(StyleManager.isValidStyleValue(getStyle('itemRollOverColor')))
	                    {
	                    	strokeColor = getStyle('itemRollOverColor');
	                    }
	                    else
	                    {
	                    	strokeColor = ColorUtil.adjustBrightness2(strokeColor, -20);
	                    }
	                    openTickColor = ColorUtil.adjustBrightness2(strokeColor, -20);
	                    closeTickColor = ColorUtil.adjustBrightness2(strokeColor, -20);
	                    break;
	                    
	                case ChartItem.DISABLED:
	                    if(StyleManager.isValidStyleValue(getStyle('itemDisabledColor')))
	                    {
	                    	strokeColor = getStyle('itemDisabledColor');
	                    }
	                    else
	                    {
	                    	strokeColor = ColorUtil.adjustBrightness2(strokeColor, 20);
	                    }
	                    openTickColor = ColorUtil.adjustBrightness2(openTickColor, 20);
	                    closeTickColor = ColorUtil.adjustBrightness2(closeTickColor, 20);
	                    break;
	                    
	                case ChartItem.FOCUSEDSELECTED:
	                case ChartItem.SELECTED:
	                    if(StyleManager.isValidStyleValue(getStyle('itemSelectionColor')))
	                    {
	                    	strokeColor = getStyle('itemSelectionColor');
	                    }
	                    else
	                    {
	                    	strokeColor = ColorUtil.adjustBrightness2(strokeColor, -30);
	                    }
	                    openTickColor = ColorUtil.adjustBrightness2(openTickColor, -30);
	                    closeTickColor = ColorUtil.adjustBrightness2(closeTickColor, -30);
	                    break;
	            }
	        }
	        else
	        {
	            openTick = 0.75 * height;
	            closeTick = 0.25 * height;
	        }
	        if(state && state != "")
	        {
	        	if(stroke)
	           		stroke.color = strokeColor;
	        	else if(lgstroke.entries.length > 0)
	           		lgstroke.entries[0].color = strokeColor;
	        	if(openTickStroke)
	            	openTickStroke.color = openTickColor;
	        	else if(lgOpenTickStroke.entries.length > 0)
	            	lgOpenTickStroke.entries[0].color = openTickColor;
	        	if(closeTickStroke)
	            	closeTickStroke.color = closeTickColor;
	        	else if(lgCloseTickStroke.entries.length > 0)
	            	lgCloseTickStroke.entries[0].color = closeTickColor;
	        }
	        var g:Graphics = graphics;
	        g.clear();
	        if(stroke)              
	        	stroke.apply(g);
	        else
	        	lgstroke.apply(g);
	        g.moveTo(w2, 0);
	        g.lineTo(w2, height);
	        if (!isNaN(openTick))
	        {
	            if(openTickStroke)
	            	openTickStroke.apply(g);
	            else
	            	lgOpenTickStroke.apply(g);
	            g.moveTo(w2, openTick);
	            g.lineTo(w2 - openTickLen, openTick);
	        }
	        if (!isNaN(closeTick))
	        {
	            if(closeTickStroke)
	            	closeTickStroke.apply(g);
	            else
	            	lgCloseTickStroke.apply(g);
	            g.moveTo(w2, closeTick);
	            g.lineTo(w2 + closeTickLen, closeTick); 
	        }
	        
	        // Restore to old colors - after selection drawing is done.
	        if(state && state != "")
	        {
	        	if(stroke)
	               	stroke.color = oldColor;
	            else if(lgstroke.entries.length > 0)
	               	lgstroke.entries[0].color = oldColor;
	            if(openTickStroke)
	                openTickStroke.color = oldOpenTickColor;
	            else if(lgOpenTickStroke.entries.length > 0)
	                lgOpenTickStroke.entries[0].color = oldOpenTickColor;
	            if(closeTickStroke)
	                closeTickStroke.color = oldCloseTickColor;
	            else if(lgCloseTickStroke.entries.length > 0)
	                lgCloseTickStroke.entries[0].color = oldCloseTickColor;
	        }
	    }
		
	}
}