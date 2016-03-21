 #include <stdio.h>

int Max(int a , int b){
	return a>b ? a : b;
}

int main(){
	int i,  j,  k = 0;
	int s[4]= {0};
	int t[4]= {0};
	int r[4]= {0};
	int a[10] = {3,
		   7, 4, 
		  2, 4, 6, 
		8, 5, 9, 3};
	for(k =0; k < 4; k++){
		

		for(j = 0, i =k*(k+1)/2 ; j<= k; j++, i++){
			if(j == 0)
				t[j] = s[j];
			else
				t[j] = Max(s[j-1] , s[j]);
			r[j] = t[j] +a[i];
			//printf("%d\n", r[j]);
		}
		
		for(j = 0;j < 4;j++)
			s[j] = r[j];
	}

	int res = 0;
	for(j= 0 ; j < 4; j++){
		res = Max(res, s[j]);
	}
	printf("%d\n", res);

	
	
	return 0;
}
