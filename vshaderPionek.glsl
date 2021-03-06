#version 330

//Zmienne jednorodne
uniform mat4 P;
uniform mat4 V;
uniform mat4 M;


//Atrybuty
in vec4 vertex; //wspolrzedne wierzcholka w przestrzeni modelu
in vec4 normal; //wektor normalny w wierzcholku w przestrzeni modelu
in vec2 texCoord0; //wspolrzedne teksturowania
in vec4 c1; //Pierwsza kolumna macierzy TBN^-1 (na razie ignorowana)
in vec4 c2; //Druga kolumna macierzy TBN^-1 (na razie ignorowana)
in vec4 c3; //Trzecia kolumna macierzy TBN^-1 (na razie ignorowana)

//Zmienne interpolowane
out vec4 i_l; //wektor do swiatla(przestrzen oka)
out vec4 i_v; //wektor do obserwatora(przestrzen oka)
out vec4 i_n; //wektor normalny (przestrzen oka)
out vec2 iTexCoord0; //wspolrzedne teksturowania


void main(void) {

    vec4 lp=vec4(20,50,-20,1); //Wspolrzedne swiatla w przestrzeni swiata

    mat3 tbn = mat3(normalize(c1.rgb),normalize(c2.rgb),normalize(normal.rgb)); //odwrotna tbn
   // mat3 itbn1 = transpose(tbn);
    mat4 itbn = mat4(tbn);
    itbn[3][3]=1;
    itbn[3][0]=0;
    itbn[3][1]=0;
    itbn[3][2]=0;

    itbn[0][3]=0;
    itbn[1][3]=0;
    itbn[2][3]=0;
    itbn=transpose(itbn);
    i_l=normalize(itbn*inverse(M)*lp-itbn*vertex);
   i_v=normalize(itbn*inverse(V*M)*vec4(0,0,0,1)-itbn*vertex);
  i_n=normalize(itbn*normalize(normal));

   // i_l=normalize(V*lp-V*M*vertex);
  //  i_v=normalize(vec4(0,0,0,1)-V*M*vertex);
   // i_n=normalize(V*M*normalize(normal));

    iTexCoord0=texCoord0;

	gl_Position=P*V*M*vertex;
}


