module mul(ina,inb,out);
output[7:0] out;
input[3:0] ina,inb;
reg[7:0] out,temp,ci;
integer i,j;
always @(ina,inb)
    begin
    out=8'h00;
    for(i=0;i<4;i=i+1)
    begin            
        if(inb&(1<<i))
        begin
temp=ina<<i;
end
else 
begin
temp=8'h00;
end
begin
for(j=0;j<8;j=j+1)
begin
if(j==0)
begin
ci[j]=out[j]&temp[j];
out[j]=out[j]^temp[j];
end
                else
                begin
                    ci[j]=(out[j]&temp[j])|(out[j]&ci[j-1])|(temp[j]&ci[j-1]);
                    out[j]=out[j]^temp[j]^ci[j-1];
                end
            end
        end
    end
end
endmodule 