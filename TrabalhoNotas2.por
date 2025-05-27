programa
{
    inclua biblioteca Matematica --> m

    const inteiro TOTAL_ALUNOS = 15  // Aumentado de 10 para 15
    const inteiro TOTAL_MATERIAS = 3

    cadeia materias[TOTAL_MATERIAS] = { "Matemática", "Português", "Ciências" }

    // Arrays com alunos iniciais + vagas extras
    cadeia turma_matematica[TOTAL_ALUNOS] = { 
        "Ana", "Bruno", "Camila", "Diego", "Eduarda", 
        "Felipe", "Gabriela", "Henrique", "Isabela", "João",
        "VAGA", "VAGA", "VAGA", "VAGA", "VAGA"
    }
    
    cadeia turma_portugues[TOTAL_ALUNOS] = { 
        "Lucas", "Marina", "Nina", "Otávio", "Patrícia", 
        "Quirino", "Rafael", "Sofia", "Tiago", "Ursula",
        "VAGA", "VAGA", "VAGA", "VAGA", "VAGA"
    }
    
    cadeia turma_ciencias[TOTAL_ALUNOS] = { 
        "Valéria", "William", "Xuxa", "Yara", "Zeca", 
        "Alex", "Bia", "Carlos", "Dora", "Elena",
        "VAGA", "VAGA", "VAGA", "VAGA", "VAGA"
    }

    real nota1[TOTAL_MATERIAS][TOTAL_ALUNOS]
    real nota2[TOTAL_MATERIAS][TOTAL_ALUNOS]
    real recuperacao[TOTAL_MATERIAS][TOTAL_ALUNOS]
    real media_inicial[TOTAL_MATERIAS][TOTAL_ALUNOS]
    real media_final[TOTAL_MATERIAS][TOTAL_ALUNOS]

    funcao cadeia get_nome_aluno(inteiro materia, inteiro aluno)
    {
        se (materia == 0)
            retorne turma_matematica[aluno]
        senao se (materia == 1)
            retorne turma_portugues[aluno]
        senao
            retorne turma_ciencias[aluno]
    }

    funcao imprimir_boletim(inteiro materia, inteiro aluno)
    {
        cadeia nomeAluno = get_nome_aluno(materia, aluno)
        escreva("\n--- Boletim do aluno: ", nomeAluno, " - ", materias[materia], " ---\n")
        escreva("Nota 1: ", nota1[materia][aluno], "\n")
        escreva("Nota 2: ", nota2[materia][aluno], "\n")
        escreva("Média Inicial: ", m.arredondar(media_inicial[materia][aluno], 2), "\n")
        se (media_inicial[materia][aluno] < 7)
        {
            escreva("Nota Recuperação: ", recuperacao[materia][aluno], "\n")
        }
        escreva("Média Final: ", m.arredondar(media_final[materia][aluno], 2), "\n\n")
    }

    funcao mostrar_media_turma(inteiro materia)
    {
        real soma = 0
        inteiro i, contador = 0

        para (i = 0; i < TOTAL_ALUNOS; i++)
        {
            se (media_final[materia][i] >= 0)
            {
                soma = soma + media_final[materia][i]
                contador = contador + 1
            }
        }

        se (contador > 0)
        {
            escreva("\nMédia da turma de ", materias[materia], ": ", m.arredondar(soma / contador, 2), "\n")
        }
        senao
        {
            escreva("\nAinda não há médias lançadas para a turma de ", materias[materia], ".\n")
        }
    }

    funcao adicionar_aluno(inteiro materia)
    {
        cadeia nome
        inteiro i

        escreva("Digite o nome do novo aluno para a turma de ", materias[materia], ": ")
        leia(nome)

        para (i = 0; i < TOTAL_ALUNOS; i++)
        {
            se (get_nome_aluno(materia, i) == "VAGA")
            {
                se (materia == 0)
                    turma_matematica[i] = nome
                senao se (materia == 1)
                    turma_portugues[i] = nome
                senao
                    turma_ciencias[i] = nome

                escreva("Aluno adicionado na posição ", i, "\n")
                retorne
            }
        }

        escreva("Não há vagas disponíveis nessa turma!\n")
    }

    funcao remover_aluno(inteiro materia)
    {
        inteiro i

        escreva("\n--- Alunos da turma de ", materias[materia], " ---\n")
        para (i = 0; i < TOTAL_ALUNOS; i++)
        {
            se (get_nome_aluno(materia, i) != "VAGA")
                escreva(i, " - ", get_nome_aluno(materia, i), "\n")
        }

        escreva("Digite o número do aluno para remover: ")
        leia(i)

        se (i >= 0 e i < TOTAL_ALUNOS e get_nome_aluno(materia, i) != "VAGA")
        {
            se (materia == 0)
                turma_matematica[i] = "VAGA"
            senao se (materia == 1)
                turma_portugues[i] = "VAGA"
            senao
                turma_ciencias[i] = "VAGA"

            // Reseta as notas do aluno removido
            nota1[materia][i] = -1
            nota2[materia][i] = -1
            recuperacao[materia][i] = -1
            media_inicial[materia][i] = -1
            media_final[materia][i] = -1

            escreva("Aluno removido da turma.\n")
        }
        senao
        {
            escreva("Posição inválida ou vaga já vazia.\n")
        }
    }

    funcao mostrar_vagas_disponiveis(inteiro materia)
    {
        inteiro vagas = 0
        inteiro i

        para (i = 0; i < TOTAL_ALUNOS; i++)
        {
            se (get_nome_aluno(materia, i) == "VAGA")
            {
                vagas = vagas + 1
            }
        }

        escreva("\nVagas disponíveis na turma de ", materias[materia], ": ", vagas, "/", TOTAL_ALUNOS, "\n")
    }

    funcao calcular_medias(inteiro materia, inteiro aluno)
    {
        // Calcula média inicial
        media_inicial[materia][aluno] = (nota1[materia][aluno] + nota2[materia][aluno]) / 2

        // Calcula média final
        se (media_inicial[materia][aluno] < 7 e recuperacao[materia][aluno] >= 0)
        {
            media_final[materia][aluno] = (media_inicial[materia][aluno] + recuperacao[materia][aluno]) / 2
        }
        senao
        {
            media_final[materia][aluno] = media_inicial[materia][aluno]
        }
    }

    funcao inicio()
    {
        inteiro i, j, opcao, materia, aluno

        // Inicializa notas
        para (i = 0; i < TOTAL_MATERIAS; i++)
        {
            para (j = 0; j < TOTAL_ALUNOS; j++)
            {
                nota1[i][j] = -1
                nota2[i][j] = -1
                recuperacao[i][j] = -1
                media_inicial[i][j] = -1
                media_final[i][j] = -1
            }
        }

        faca
        {
            escreva("\n--- MENU PRINCIPAL ---\n")
            escreva("1 - Inserir notas de aluno\n")
            escreva("2 - Imprimir boletim de aluno\n")
            escreva("3 - Ver média da turma por matéria\n")
            escreva("4 - Adicionar aluno em uma turma\n")
            escreva("5 - Remover aluno de uma turma\n")
            escreva("6 - Ver vagas disponíveis\n")
            escreva("7 - Sair\n")
            escreva("Escolha uma opção: ")
            leia(opcao)

            escolha (opcao)
            {
                caso 1:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        escreva("\n--- Alunos da turma de ", materias[materia], " ---\n")
                        para (j = 0; j < TOTAL_ALUNOS; j++)
                        {
                            se (get_nome_aluno(materia, j) != "VAGA")
                                escreva(j, " - ", get_nome_aluno(materia, j), "\n")
                        }
                        
                        escreva("Selecione o aluno: ")
                        leia(aluno)

                        se (aluno >= 0 e aluno < TOTAL_ALUNOS e get_nome_aluno(materia, aluno) != "VAGA")
                        {
                            escreva("Digite a nota 1: ")
                            leia(nota1[materia][aluno])
                            escreva("Digite a nota 2: ")
                            leia(nota2[materia][aluno])

                            calcular_medias(materia, aluno)

                            se (media_inicial[materia][aluno] < 7)
                            {
                                escreva("Aluno precisa de recuperação. Digite a nota de recuperação: ")
                                leia(recuperacao[materia][aluno])
                                calcular_medias(materia, aluno)
                            }

                            escreva("Notas inseridas com sucesso!\n")
                        }
                        senao
                        {
                            escreva("Aluno inválido!\n")
                        }
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 2:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        escreva("\n--- Alunos da turma de ", materias[materia], " ---\n")
                        para (j = 0; j < TOTAL_ALUNOS; j++)
                        {
                            se (get_nome_aluno(materia, j) != "VAGA")
                                escreva(j, " - ", get_nome_aluno(materia, j), "\n")
                        }
                        
                        escreva("Selecione o aluno: ")
                        leia(aluno)

                        se (aluno >= 0 e aluno < TOTAL_ALUNOS e get_nome_aluno(materia, aluno) != "VAGA" e nota1[materia][aluno] >= 0)
                        {
                            imprimir_boletim(materia, aluno)
                        }
                        senao
                        {
                            escreva("Aluno inválido ou sem notas lançadas!\n")
                        }
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 3:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        mostrar_media_turma(materia)
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 4:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        mostrar_vagas_disponiveis(materia)
                        adicionar_aluno(materia)
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 5:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        remover_aluno(materia)
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 6:
                    escreva("\nSelecione a matéria:\n")
                    para (i = 0; i < TOTAL_MATERIAS; i++) 
                        escreva(i, " - ", materias[i], "\n")
                    leia(materia)

                    se (materia >= 0 e materia < TOTAL_MATERIAS)
                    {
                        mostrar_vagas_disponiveis(materia)
                    }
                    senao
                    {
                        escreva("Matéria inválida!\n")
                    }
                    pare

                caso 7:
                    escreva("Encerrando o programa...\n")
                    pare

                caso contrario:
                    escreva("Opção inválida! Tente novamente.\n")
                    pare
            }
        }
        enquanto (opcao != 7)
    }
}