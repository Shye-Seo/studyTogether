import java.util.Calendar;

public class dday {

	public static void main(String[] args) {
		Calendar startday = Calendar.getInstance();
		Calendar dday = Calendar.getInstance();
		
		String start = "2022.01.01";
		String finish = "2022.02.02";

		int startYear = Integer.parseInt(start.substring(0,4));
		int startMonth = Integer.parseInt(start.substring(5,7));
		int startDate = Integer.parseInt(start.substring(8));

		int finishYear = Integer.parseInt(finish.substring(0,4));
		int finishMonth = Integer.parseInt(finish.substring(5,7));
		int finishDate = Integer.parseInt(finish.substring(8));
		  
		dday.set(finishYear, finishMonth-1, finishDate); //디데이 날짜 설정
		startday.set(startYear, startMonth-1, startDate); //기준 날짜 설정
		
		long l_dday = dday.getTimeInMillis() / (24*60*60*1000);
		long l_startday = startday.getTimeInMillis() / (24*60*60*1000);
		
		long substract = 0;
		String ddayStr = "D";
		
		if (l_startday > l_dday) {
			substract = l_startday-l_dday;
			ddayStr = "종료";
		} else if (l_startday < l_dday) {
			substract = l_dday-l_startday;
			ddayStr += "-" + substract;
		} else {
			ddayStr += "-Day";
		}
		System.out.println(l_dday);
		System.out.println(l_startday);
		System.out.println(l_startday - l_dday);
		System.out.println(ddayStr);
	}

}
