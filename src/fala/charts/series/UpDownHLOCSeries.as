package fala.charts.series
{
	import mx.charts.series.HLOCSeries;
	
	[Style(name="upColor", type="uint", format="Color", inherit="no")]
	[Style(name="downColor", type="uint", format="Color", inherit="no")]
	
	public class UpDownHLOCSeries extends HLOCSeries
	{
		public function UpDownHLOCSeries()
		{
			super();
		}
	}
}